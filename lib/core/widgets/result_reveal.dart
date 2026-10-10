import 'package:flutter/material.dart';

class ResultReveal extends StatefulWidget {
  const ResultReveal({super.key, required this.child});

  final Widget child;

  @override
  State<ResultReveal> createState() => _ResultRevealState();
}

class _ResultRevealState extends State<ResultReveal>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAccessibilityFeatures() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final features = WidgetsBinding.instance.accessibilityFeatures;
    final reduceMotion =
        MediaQuery.disableAnimationsOf(context) || features.reduceMotion;

    if (reduceMotion) {
      return widget.child;
    }

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      tween: Tween(begin: 0, end: 1),
      child: widget.child,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 10 * (1 - value)),
            child: child,
          ),
        );
      },
    );
  }
}
