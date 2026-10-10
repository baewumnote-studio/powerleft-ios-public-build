import 'package:flutter/material.dart';
import '../../l10n/generated/app_localizations.dart';

Future<String?> showSetupNameDialog(
  BuildContext context, {
  required String title,
  required String initialName,
}) => showDialog<String>(
  context: context,
  builder: (_) => _SetupNameDialog(title: title, initialName: initialName),
);

class _SetupNameDialog extends StatefulWidget {
  const _SetupNameDialog({required this.title, required this.initialName});
  final String title, initialName;
  @override
  State<_SetupNameDialog> createState() => _SetupNameDialogState();
}

class _SetupNameDialogState extends State<_SetupNameDialog> {
  late final TextEditingController controller = TextEditingController(
    text: widget.initialName,
  );
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        autofocus: true,
        controller: controller,
        maxLength: 80,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(labelText: l.saveSetupName),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l.commonCancel),
        ),
        FilledButton(
          onPressed: () {
            final value = controller.text.trim();
            if (value.isNotEmpty) Navigator.pop(context, value);
          },
          child: Text(l.commonSave),
        ),
      ],
    );
  }
}
