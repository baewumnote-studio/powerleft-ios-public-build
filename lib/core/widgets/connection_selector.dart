import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/models/enums.dart';

class ConnectionSelector extends StatelessWidget {
  const ConnectionSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final ConnectionType value;
  final ValueChanged<ConnectionType> onChanged;

  @override
  Widget build(BuildContext context) {
    final scaledBody = MediaQuery.textScalerOf(context).scale(16);
    final narrow = MediaQuery.sizeOf(context).width < 360;
    final useDropdown = scaledBody > 20 || narrow;

    if (useDropdown) {
      return DropdownButtonFormField<ConnectionType>(
        key: ValueKey(value),
        initialValue: value,
        items: ConnectionType.values
            .map(
              (type) =>
                  DropdownMenuItem(value: type, child: Text(type.shortLabel)),
            )
            .toList(),
        onChanged: (next) {
          if (next != null) {
            HapticFeedback.selectionClick();
            onChanged(next);
          }
        },
      );
    }

    return SegmentedButton<ConnectionType>(
      segments: ConnectionType.values
          .map(
            (type) => ButtonSegment(value: type, label: Text(type.shortLabel)),
          )
          .toList(),
      selected: {value},
      onSelectionChanged: (selection) {
        if (selection.isNotEmpty) {
          HapticFeedback.selectionClick();
          onChanged(selection.first);
        }
      },
    );
  }
}
