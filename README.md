# DID App - Portefeuille d'Identité Numérique Européen

Application mobile de portefeuille d'identité numérique conforme aux standards eIDAS 2.0 et EUDI Wallet.

## 🌟 C'est quoi une identité numérique ? 

Imaginez votre portefeuille physique, qui contient vos cartes d'identité, permis de conduire, cartes d'assurance santé et diplômes. L'identité numérique, c'est exactement ça, mais sur votre téléphone !

Cette application vous permet de :
- Stocker vos documents d'identité sous forme numérique, sécurisée et certifiée
- Prouver qui vous êtes en ligne sans partager toutes vos informations
- Contrôler quelles informations vous partagez, avec qui et quand
- Utiliser vos documents d'identité pour vous connecter à des services en ligne

## 🇪🇺 EUDI Wallet & eIDAS 2.0 : Pourquoi c'est important ?

### EUDI Wallet (European Digital Identity Wallet)
C'est un portefeuille d'identité numérique standardisé pour tous les citoyens européens. Il permettra de :
- Avoir une identité numérique reconnue dans toute l'Europe
- Accéder facilement aux services publics et privés partout dans l'UE
- Bénéficier d'une protection solide de vos données personnelles

### eIDAS 2.0
C'est la réglementation européenne qui encadre les identités numériques. Elle garantit que :
- Votre identité numérique est aussi fiable qu'une pièce d'identité physique
- Les services que vous utilisez peuvent faire confiance à vos attestations numériques
- Vos données sont protégées selon les standards européens
- Votre vie privée est respectée grâce à des mécanismes comme la "divulgation sélective" (ne partager que les informations nécessaires)

## 🛡️ Approche SSI (Self-Sovereign Identity) : Votre identité VOUS appartient

La SSI, c'est la philosophie derrière notre application. Cela signifie que :

- **Vous êtes propriétaire** de vos données d'identité, pas les grandes entreprises
- **Vous décidez** quelles informations partager, avec qui et quand
- **Vous stockez** vos attestations directement sur votre appareil
- **Vous contrôlez** votre identité numérique, sans dépendre d'intermédiaires

## 🚀 Fonctionnalités pour débutants

### 1. Création et gestion d'identité facile
- Créez votre identité numérique en quelques clics
- Importez vos documents officiels via des processus simples et guidés
- Gérez facilement vos attestations avec une interface intuitive

### 2. Partage d'informations simplifié
- Partagez uniquement les informations nécessaires (par exemple, prouver que vous avez plus de 18 ans sans révéler votre date de naissance)
- Utilisez des QR codes pour vous authentifier rapidement
- Contrôlez qui a accès à vos informations avec des autorisations claires

### 3. Sécurité accessible
- Protégez votre identité avec reconnaissance faciale ou empreinte digitale
- Recevez des alertes claires en cas de problème de sécurité
- Retrouvez facilement accès à vos attestations en cas de perte de votre appareil

## 🏁 Pour commencer

1. **Installez l'application** sur votre appareil
2. **Créez votre identité numérique** en suivant le guide pas à pas
3. **Ajoutez vos attestations** (carte d'identité, permis de conduire, diplômes, etc.)
4. **Utilisez votre identité** pour des services en ligne ou en personne

## 🔧 Getting Started (Development)

Suivez ces étapes pour configurer l'environnement de développement :

1.  **Prérequis :**
    *   Assurez-vous d'avoir [Flutter](https://docs.flutter.dev/get-started/install) installé sur votre machine.
    *   Utilisez un gestionnaire de versions comme [asdf](https://asdf-vm.com/) avec le plugin Flutter pour gérer les versions SDK spécifiées dans le fichier `.tool-versions`. Installez les versions requises :
        ```bash
        asdf install
        ```
    *   (Optionnel, si applicable) Exécutez le script de configuration initiale :
        ```bash
        ./setup.sh 
        ```
        *(Note : Examinez `setup.sh` pour comprendre ce qu'il fait avant de l'exécuter).*

2.  **Cloner le dépôt :**
    ```bash
    git clone <URL_DU_DEPOT>
    cd did_app 
    ```

3.  **Installer les dépendances :**
    ```bash
    flutter pub get
    ```

4.  **Générer le code (si nécessaire) :**
    Si le projet utilise des générateurs de code (comme `build_runner`), exécutez :
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

5.  **Lancer l'application :**
    ```bash
    flutter run
    ```

6.  **Commandes utiles :**
    *   Vérifier les problèmes de code : `flutter analyze`
    *   Exécuter les tests : `flutter test`

### 🧪 Testing

Ce projet inclut des tests unitaires pour garantir la qualité et la stabilité du code. Pour exécuter tous les tests unitaires, utilisez la commande suivante à la racine du projet :

```bash
flutter test
```

## Fonctionnalités Implémentées

1. **Gestion des Attestations**
   - Création et stockage d'attestations numériques
   - Support des formats W3C Verifiable Credentials
   - Vérification de l'intégrité des attestations
   - Gestion des preuves cryptographiques
   - Support des attestations qualifiées selon eIDAS 2.0
   - Intégration avec les services de confiance qualifiés
   - Vérification des signatures électroniques qualifiées
   - Gestion des niveaux d'assurance (Low, Substantial, High)

2. **Portefeuille d'Identité**
   - Stockage sécurisé des attestations
   - Gestion des clés privées
   - Support des DIDs (Decentralized Identifiers)
   - Authentification biométrique
   - Chiffrement des données sensibles
   - Support des attestations qualifiées
   - Intégration avec le registre de confiance européen

3. **Authentification Sécurisée**
   - Authentification biométrique (empreintes digitales, reconnaissance faciale)
   - Support multi-facteurs (MFA)
   - Gestion des clés cryptographiques
   - Protection des données sensibles

4. **Interopérabilité eIDAS 2.0**
   - Conformité avec les standards européens
   - Support des formats d'attestation eIDAS
   - Intégration avec le Registre de Confiance Européen
   - Vérification des émetteurs de confiance
   - Filtrage par pays et niveau de confiance
   - Rapports d'interopérabilité

5. **Sécurité et Confidentialité**
   - Chiffrement de bout en bout
   - Stockage sécurisé des données
   - Protection contre les attaques
   - Conformité RGPD

## 📚 Glossaire pour débutants

- **Attestation** : Un document numérique certifié qui prouve quelque chose à votre sujet (votre identité, vos diplômes, etc.)
- **Portefeuille numérique** : Une application qui stocke vos attestations numériques de façon sécurisée
- **Émetteur** : L'organisation qui crée et certifie une attestation (par exemple, l'État pour une carte d'identité)
- **Vérificateur** : La personne ou l'organisation qui vérifie vos attestations
- **Niveaux d'assurance** : Le degré de confiance associé à une attestation (faible, substantiel, élevé)
- **Divulgation sélective** : La possibilité de ne partager qu'une partie des informations contenues dans une attestation
- **Preuve à divulgation nulle** : Une technologie qui vous permet de prouver quelque chose sans révéler d'informations supplémentaires

## 🔗 Ressources utiles pour en savoir plus

- [Guide du citoyen pour l'identité numérique européenne](https://digital-strategy.ec.europa.eu/en/policies/european-digital-identity)
- [Explications simples sur eIDAS 2.0](https://www.youtube.com/watch?v=OO_MyjiAgr0)
- [Comment protéger votre identité numérique](https://cybersecurityguide.org/resources/digital-identity-protection/)

## Fonctionnalités en Développement

1. **Gestion de Révocation des Attestations**
   - Implémentation du Status List 2021
   - Synchronisation automatique des statuts
   - Interface de gestion des révocations
   - Système de renouvellement automatique

2. **Support des Attestations Qualifiées**
   - Intégration avec les autorités de certification qualifiées
   - Support des signatures électroniques qualifiées
   - Vérification des sceaux qualifiés
   - Conformité avec eIDAS niveau élevé

3. **Interopérabilité avec les Services Publics**
   - Intégration avec les services gouvernementaux
   - Support des cas d'usage administratifs
   - Authentification unique (SSO)
   - Services transfrontaliers

## Architecture Technique

L'application est construite avec Flutter et suit une architecture propre avec :
- Domain-Driven Design (DDD)
- Clean Architecture
- Riverpod pour la gestion d'état
- flutter_secure_storage pour le stockage local sécurisé

## Conformité

L'application est conçue pour être conforme aux :
- Règlements eIDAS 2.0
- Standards EUDI Wallet
- Directives de sécurité européennes
- Règlement Général sur la Protection des Données (RGPD)

## FAQ pour débutants

### 🤔 Est-ce que cette application remplace mes documents officiels ?
Oui et non. Vos attestations numériques sont légalement reconnues dans l'UE grâce à eIDAS 2.0, mais il est recommandé de conserver vos documents physiques pour certaines situations.

### 🔒 Mes données sont-elles en sécurité ?
Absolument ! Vos données sont stockées uniquement sur votre appareil, chiffrées, et vous seul pouvez les débloquer. Même si vous perdez votre téléphone, personne ne peut accéder à vos informations.

### 🌍 Puis-je utiliser cette application dans toute l'Europe ?
Oui, c'est justement l'objectif d'EUDI Wallet et d'eIDAS 2.0 : créer un système d'identité numérique qui fonctionne partout en Europe.

### 📱 Que se passe-t-il si je change de téléphone ?
L'application propose une fonctionnalité de sauvegarde et restauration qui vous permet de transférer en toute sécurité vos attestations vers votre nouvel appareil.

## Contribution

Les contributions sont les bienvenues ! Si vous souhaitez améliorer ce template :

1. Forkez le dépôt
2. Créez votre branche de fonctionnalité (`git checkout -b feature/amazing-feature`)
3. Committez vos changements (`git commit -m 'Add some amazing feature'`)
4. Poussez vers la branche (`git push origin feature/amazing-feature`)
5. Ouvrez une Pull Request

## 🔐 Gestion de l'Identité et Interaction Wallet

Cette application gère l'identité numérique de l'utilisateur en s'appuyant sur la blockchain Archethic et le portefeuille externe **Archethic Wallet (aeWallet)**. L'interaction se fait via le protocole **Archethic Wallet Client (AWC)**.

### Flux d'Identité

1.  **Connexion :** L'utilisateur connecte son aeWallet à la dApp en utilisant un de ses comptes/services existants (par exemple, son compte UCO principal).
2.  **Création du Service dApp :** Pour lier l'identité de l'utilisateur spécifiquement à cette dApp, l'application demande à aeWallet de créer un nouveau **service** dédié (par exemple, `did_app_profile`) au sein de la Keychain de l'utilisateur. Cette opération est initiée par la dApp mais confirmée et exécutée par l'utilisateur dans son aeWallet. Ce service crée une nouvelle paire de clés cryptographiques sous le contrôle de l'utilisateur, associée à son identité dans le contexte de la dApp.
3.  **Utilisation :**
    *   Le DID (Decentralized Identifier) de l'utilisateur est dérivé de sa Keychain gérée par aeWallet.
    *   Les informations d'identité spécifiques à l'application (attributs, attestations) sont gérées sous forme de **Verifiable Credentials (VCs)**.
    *   Les opérations nécessitant une signature cryptographique liée à l'identité dApp (par exemple, émettre un VC auto-signé, créer une présentation de VCs) devraient idéalement utiliser la clé associée au service dApp (`did_app_profile`).
4.  **Gestion du Compte Actif (Important) :** Pour les opérations nécessitant la clé spécifique du service dApp, l'utilisateur **pourrait avoir besoin de sélectionner manuellement ce service comme compte actif dans son aeWallet** avant de confirmer l'opération. La dApp tentera de détecter le compte actif et guidera l'utilisateur si un changement est nécessaire.

### Verifiable Credentials (VCs)

L'application utilisera le standard W3C Verifiable Credentials pour représenter les attributs d'identité et les attestations (conformité eIDAS 2.0).

*   Les VCs peuvent être émis par des tiers de confiance ou par l'utilisateur lui-même (Self-Issued).
*   Le stockage des VCs sera géré de manière sécurisée (potentiellement stockage local chiffré ou via des transactions `DATA` sur la blockchain Archethic, signées via AWC).
*   Le service dApp dans la Keychain ancre cryptographiquement l'identité de l'utilisateur (`did`) qui est le sujet (`subject`) des VCs.

### Exemple de Document DID W3C (issu d'une Keychain Archethic)

Le document DID est généré à partir de la Keychain de l'utilisateur et représente ses clés publiques associées aux différents services. Voici un exemple simplifié :

```json
{
  "@context": [
    "https://www.w3.org/ns/did/v1",
    "https://w3id.org/security/suites/jws-2020/v1" // Context for JWK
  ],
  // The DID identifier is based on the keychain's genesis address
  "id": "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142",
  "verificationMethod": [
    {
      // Identifier for the key associated with the 'uco' service
      "id": "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142#uco",
      // Controller is the DID itself
      "controller": "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142",
      // Type indicating the key format
      "type": "JsonWebKey2020",
      // The public key in JWK format
      "publicKeyJwk": {
        "kty": "OKP", // Key Type: Octet Key Pair
        "crv": "Ed25519", // Curve: Ed25519
        "x": "THUxvsx2-3dAwofe-0YNINr9afALrSnPKdPJX6Ndh0U" // Public key value (base64url encoded)
      }
    },
    {
      // Identifier for the key associated with the dApp-specific service
      "id": "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142#did_app_profile",
      "controller": "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142",
      "type": "JsonWebKey2020",
      "publicKeyJwk": {
        "kty": "OKP",
        "crv": "Ed25519",
        "x": "R3ehm94B6wgxWHU9jhv__-pQPYaXV3bgQzmG0515wGY" // Different public key for this service
      }
    }
    // ... other services/keys ...
  ],
  // Methods that can be used to authenticate as the DID subject
  "authentication": [
    "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142#uco",
    "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142#did_app_profile"
    // ... other authentication methods ...
  ],
  // Methods that can be used to assert claims about the DID subject (e.g., sign VCs)
  "assertionMethod": [
     "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142#uco",
     "did:archethic:0000db44763a3dc1aafe7b5ba7b7da6d8f631aad081c0099b64214518d8ddd402142#did_app_profile"
     // ... other assertion methods ...
  ]
  // Potentially other DID document properties like 'service', 'keyAgreement', etc.
}
```



