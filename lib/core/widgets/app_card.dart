import 'package:flutter/material.dart';
import '../constants/app_values.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppValues.cardPadding),
    this.color,
  });
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context), dark = theme.brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: color,
        gradient: color == null
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: dark
                    ? const [Color(0xFF0B5142), Color(0xFF063B32)]
                    : const [Colors.white, Color(0xFFF6FBF8)],
              )
            : null,
        borderRadius: BorderRadius.circular(AppValues.cardRadius),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: dark ? .22 : .14),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: dark ? .1 : .035),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
