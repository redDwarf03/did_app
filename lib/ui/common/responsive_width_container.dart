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
  static const double _maxMobileWidth = 430.0;

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
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          height: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
