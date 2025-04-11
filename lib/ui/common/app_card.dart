import 'package:flutter/material.dart';

/// Carte réutilisable avec un style commun pour l'application
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.elevation = 1,
    this.borderRadius = 12,
  });

  /// Contenu de la carte
  final Widget child;

  /// Marge interne
  final EdgeInsetsGeometry? padding;

  /// Marge externe
  final EdgeInsetsGeometry? margin;

  /// Couleur de fond (null pour utiliser la couleur surface du thème)
  final Color? color;

  /// Élévation de la carte (ombre)
  final double elevation;

  /// Rayon de bordure de la carte
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: elevation,
      margin: margin ?? const EdgeInsets.only(bottom: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      color: color ?? theme.colorScheme.surface,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
