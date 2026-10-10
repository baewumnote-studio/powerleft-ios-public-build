import 'package:flutter/material.dart';

class WarningCard extends StatelessWidget {
  const WarningCard({
    super.key,
    required this.title,
    required this.body,
    this.critical = false,
  });
  final String title, body;
  final bool critical;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context),
        color = critical ? theme.colorScheme.error : theme.colorScheme.tertiary;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: .25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              critical
                  ? Icons.error_outline_rounded
                  : Icons.warning_amber_rounded,
              color: color,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
