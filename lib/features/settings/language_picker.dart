import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/power_visuals.dart';
import '../../l10n/app_languages.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../providers.dart';

abstract final class LanguagePicker {
  static Future<void> show(BuildContext context, WidgetRef ref) async {
    final code = ref.read(localeProvider)?.languageCode ?? 'system';
    final chosen = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        final l = AppLocalizations.of(context);
        final choices = {
          'system': l.settingsLanguageSystem,
          ...AppLanguages.nativeNames,
        };
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * .82,
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: Row(
                    children: [
                      const PowerIconTile(icon: Icons.translate_rounded),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l.settingsLanguage,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      IconButton(
                        tooltip: l.commonClose,
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                    children: [
                      for (final choice in choices.entries)
                        ListTile(
                          key: ValueKey('language-option-${choice.key}'),
                          title: Text(choice.value),
                          selected: choice.key == code,
                          selectedColor: Theme.of(context).colorScheme.primary,
                          leading: choice.key == 'system'
                              ? const Icon(Icons.phone_iphone_rounded)
                              : const Icon(Icons.language_rounded),
                          trailing: choice.key == code
                              ? const Icon(Icons.check_rounded)
                              : null,
                          onTap: () => Navigator.pop(context, choice.key),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (chosen == null || !context.mounted) return;
    try {
      await ref
          .read(localeProvider.notifier)
          .setLanguageCode(chosen == 'system' ? null : chosen);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).errorSaveData)),
        );
      }
    }
  }
}
