import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Widget that constrains the application's width on the web to match
/// that of an iPhone Pro Max
class ResponsiveWidthContainer extends StatelessWidget {
  const ResponsiveWidthContainer({
    required this.child,
    super.key,
  });

  final Widget child;

  // Width of an iPhone Pro Max
  static const double _maxMobileWidth = 430;

  @override
  Widget build(BuildContext context) {
    // If it's not web, return the child directly
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
              // Ignore horizontal scrolling on the web
              // to allow swiping like on mobile
            },
            child: child,
          ),
        ),
      ),
    );
  }
}
