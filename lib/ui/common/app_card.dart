import 'package:flutter/material.dart';

/// Styled card widget for the application
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

  /// Card title
  final String? title;

  /// Card content
  final Widget child;

  /// Card accent color
  final Color? accentColor;

  /// Additional action (icon on the top right)
  final Widget? actionIcon;

  /// Callback for the additional action
  final VoidCallback? onActionPressed;

  /// Card elevation
  final double elevation;

  /// If the card is expandable
  final bool isExpanded;

  /// If the card is currently expanded (if expandable)
  final bool? expanded;

  /// Callback during expansion
  final Function(bool)? onExpansionChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = accentColor ?? theme.primaryColor;

    // If the card is expandable
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

    // Standard card
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
          // Main content
          child,
        ],
      ),
    );
  }
}
