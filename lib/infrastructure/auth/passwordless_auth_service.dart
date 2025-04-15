import 'dart:convert';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

/// Service pour gérer l'authentification sans mot de passe
class PasswordlessAuthService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final String _tokenKey = 'auth_token';
  final String _tokenExpiryKey = 'auth_token_expiry';
  final String _emailKey = 'auth_email';

  // URL de base pour les liens magiques (à remplacer par votre URL réelle)
  final String _baseUrl = 'https://votreapp.com/auth';

  /// Génère un lien magique pour l'authentification sans mot de passe
  Future<String> generateMagicLink(String email) async {
    try {
      // Générer un jeton unique
      final token = _generateToken();

      // Définir une expiration (15 minutes)
      final expiry = DateTime.now().add(const Duration(minutes: 15));

      // Stocker le jeton et son expiration
      await _secureStorage.write(key: _tokenKey, value: token);
      await _secureStorage.write(
        key: _tokenExpiryKey,
        value: expiry.millisecondsSinceEpoch.toString(),
      );
      await _secureStorage.write(key: _emailKey, value: email);

      // Créer le lien magique
      final magicLink =
          '$_baseUrl?token=$token&email=${Uri.encodeComponent(email)}';

      // Dans une implémentation réelle, ce lien serait envoyé par email
      if (kDebugMode) {
        dev.log(
          'Lien magique généré pour $email: $magicLink',
          name: 'PasswordlessAuthService.generateMagicLink',
        );
      }

      return magicLink;
    } catch (e) {
      dev.log(
        'Erreur lors de la génération du lien magique',
        name: 'PasswordlessAuthService.generateMagicLink',
        error: e,
        level: 1000, // Severe level
      );
      rethrow;
    }
  }

  /// Vérifie un jeton d'authentification
  Future<AuthVerificationResult> verifyToken(String token, String email) async {
    try {
      // Récupérer le jeton stocké et son expiration
      final storedToken = await _secureStorage.read(key: _tokenKey);
      final expiryString = await _secureStorage.read(key: _tokenExpiryKey);
      final storedEmail = await _secureStorage.read(key: _emailKey);

      // Si aucun jeton n'est stocké
      if (storedToken == null || expiryString == null || storedEmail == null) {
        return AuthVerificationResult(
          isValid: false,
          message: "Aucun jeton d'authentification en attente",
        );
      }

      // Vérifier que l'email correspond
      if (email != storedEmail) {
        return AuthVerificationResult(
          isValid: false,
          message: "L'email ne correspond pas",
        );
      }

      // Vérifier l'expiration
      final expiry =
          DateTime.fromMillisecondsSinceEpoch(int.parse(expiryString));
      if (DateTime.now().isAfter(expiry)) {
        return AuthVerificationResult(
          isValid: false,
          message: 'Le lien a expiré',
          isExpired: true,
        );
      }

      // Vérifier le jeton
      if (token == storedToken) {
        // Générer un JWT pour l'authentification de session
        final sessionToken = _generateJwt(email);

        return AuthVerificationResult(
          isValid: true,
          message: 'Authentification réussie',
          token: sessionToken,
        );
      } else {
        return AuthVerificationResult(
          isValid: false,
          message: "Jeton d'authentification invalide",
        );
      }
    } catch (e) {
      dev.log(
        'Erreur lors de la vérification du jeton',
        name: 'PasswordlessAuthService.verifyToken',
        error: e,
        level: 1000, // Severe level
      );
      return AuthVerificationResult(
        isValid: false,
        message: 'Erreur lors de la vérification: $e',
      );
    }
  }

  /// Efface le jeton après une authentification réussie
  Future<void> clearToken() async {
    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _tokenExpiryKey);
  }

  /// Génère un jeton aléatoire sécurisé
  String _generateToken() {
    const uuid = Uuid();
    final random = Random.secure();
    final randomInt = random.nextInt(1000000);
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final rawToken = '$timestamp-$randomInt-${uuid.v4()}';
    final bytes = utf8.encode(rawToken);
    final digest = sha256.convert(bytes);

    return digest.toString();
  }

  /// Génère un JWT simplifié pour l'authentification de session
  /// Note: Dans une implémentation réelle, utilisez une bibliothèque JWT complète
  String _generateJwt(String email) {
    // Créer l'en-tête
    final header = {'alg': 'HS256', 'typ': 'JWT'};

    // Créer le payload
    final payload = {
      'sub': email,
      'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'exp':
          DateTime.now().add(const Duration(days: 7)).millisecondsSinceEpoch ~/
              1000,
    };

    // Encoder l'en-tête et le payload en base64
    final encodedHeader = base64Url.encode(utf8.encode(jsonEncode(header)));
    final encodedPayload = base64Url.encode(utf8.encode(jsonEncode(payload)));

    // Dans une implémentation réelle, nous signerions réellement le JWT avec une clé secrète
    // Pour cette démo, nous utilisons un secret fixe
    const secret = 'votre_secret_tres_long_et_tres_complexe';
    final data = '$encodedHeader.$encodedPayload';
    final bytes = utf8.encode(data + secret);
    final signature = base64Url.encode(sha256.convert(bytes).bytes);

    // Assembler le JWT
    return '$encodedHeader.$encodedPayload.$signature';
  }

  /// Vérifie si l'utilisateur est déjà authentifié
  Future<bool> isAuthenticated() async {
    try {
      final token = await _secureStorage.read(key: 'session_token');
      if (token == null) return false;

      // Dans une implémentation réelle, nous vérifierions si le JWT est valide
      // Pour cette démo, nous supposons qu'il est valide
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Enregistre le jeton de session
  Future<void> saveSessionToken(String token) async {
    await _secureStorage.write(key: 'session_token', value: token);
  }
}

/// Résultat de la vérification d'authentification
class AuthVerificationResult {
  AuthVerificationResult({
    required this.isValid,
    required this.message,
    this.isExpired = false,
    this.token,
  });
  final bool isValid;
  final String message;
  final bool isExpired;
  final String? token;
}
