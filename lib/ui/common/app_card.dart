import 'package:flutter/material.dart';

/// Widget de carte stylisée pour l'application
class AppCard extends StatelessWidget {

  const AppCard({
    super.key,
    this.title,
    required this.child,
    this.accentColor,
    this.actionIcon,
    this.onActionPressed,
    this.elevation = 1,
    this.isExpanded = false,
    this.expanded,
    this.onExpansionChanged,
  });
  /// Titre de la carte
  final String? title;

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = accentColor ?? theme.primaryColor;

    // Si la carte est expansible
    if (isExpanded) {
      return Card(
        elevation: elevation,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ExpansionTile(
          initiallyExpanded: expanded ?? false,
          onExpansionChanged: onExpansionChanged,
          title: Text(
            title ?? '',
            style: theme.textTheme.titleMedium,
          ),
          trailing: actionIcon != null
              ? IconButton(
                  icon: actionIcon!,
                  onPressed: onActionPressed,
                )
              : null,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
          ],
        ),
      );
    }

    // Carte standard
    return Card(
      elevation: elevation,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title!,
                    style: theme.textTheme.titleMedium,
                  ),
                  if (actionIcon != null)
                    IconButton(
                      icon: actionIcon!,
                      onPressed: onActionPressed,
                    ),
                ],
              ),
            ),
            const Divider(),
          ],
          // Contenu principal
          child,
        ],
      ),
    );
  }
}
