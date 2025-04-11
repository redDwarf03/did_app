import 'package:flutter/material.dart';

/// Widget de carte stylisée pour l'application
class AppCard extends StatelessWidget {
  /// Titre de la carte
  final String title;

  /// Contenu de la carte
  final Widget child;

  /// Couleur d'accent de la carte
  final Color? accentColor;

  /// Action supplémentaire (icône en haut à droite)
  final Widget? actionIcon;

  /// Callback pour l'action supplémentaire
  final VoidCallback? onActionPressed;

  /// Élévation de la carte
  final double elevation;

  /// Si la carte est expansible
  final bool isExpanded;

  /// Si la carte est actuellement étendue (si expansible)
  final bool? expanded;

  /// Callback lors de l'expansion
  final Function(bool)? onExpansionChanged;

  const AppCard({
    super.key,
    required this.title,
    required this.child,
    this.accentColor,
    this.actionIcon,
    this.onActionPressed,
    this.elevation = 2.0,
    this.isExpanded = false,
    this.expanded,
    this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveAccentColor = accentColor ?? theme.primaryColor;

    if (isExpanded) {
      return Card(
        elevation: elevation,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          title: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.textTheme.titleMedium?.color,
              fontWeight: FontWeight.bold,
            ),
          ),
          initiallyExpanded: expanded ?? true,
          onExpansionChanged: onExpansionChanged,
          childrenPadding: const EdgeInsets.only(bottom: 16),
          trailing: actionIcon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: onActionPressed,
                      child: actionIcon,
                    ),
                    const Icon(Icons.expand_more),
                  ],
                )
              : null,
          children: [child],
        ),
      );
    }

    return Card(
      elevation: elevation,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: effectiveAccentColor.withOpacity(0.08),
              border: Border(
                bottom: BorderSide(
                  color: effectiveAccentColor.withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.textTheme.titleMedium?.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (actionIcon != null)
                  GestureDetector(
                    onTap: onActionPressed,
                    child: actionIcon,
                  ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}
