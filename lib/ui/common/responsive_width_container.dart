import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Widget qui contraint la largeur de l'application sur le web pour correspondre
/// à celle d'un iPhone Pro Max
class ResponsiveWidthContainer extends StatelessWidget {
  const ResponsiveWidthContainer({
    required this.child,
    super.key,
  });

  final Widget child;

  // Largeur d'un iPhone Pro Max
  static const double _maxMobileWidth = 430;

  @override
  Widget build(BuildContext context) {
    // Si ce n'est pas le web, on retourne directement le child
    if (!kIsWeb) {
      return child;
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: _maxMobileWidth,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
              ),
            ],
          ),
          height: double.infinity,
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              // On ignore le défilement horizontal sur le web
              // pour permettre le swipe comme sur mobile
            },
            child: child,
          ),
        ),
      ),
    );
  }
}
