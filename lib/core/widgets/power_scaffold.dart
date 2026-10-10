import 'package:flutter/material.dart';
import '../constants/app_values.dart';
import '../../l10n/generated/app_localizations.dart';
import 'power_visuals.dart';

class PowerScaffold extends StatelessWidget {
  const PowerScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.bottom,
    this.subtitle,
    this.compactTitle = false,
  });
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? bottom;
  final String? subtitle;
  final bool compactTitle;
  @override
  Widget build(BuildContext context) {
    final keyboardVisible = MediaQuery.viewInsetsOf(context).bottom > 0;
    final l = AppLocalizations.of(context),
        scheme = Theme.of(context).colorScheme;
    return PowerBackdrop(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 64,
          title: Text(
            compactTitle ? title : 'PowerLeft',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          centerTitle: compactTitle,
          leading: Navigator.canPop(context)
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 0, 10),
                  child: BackButton(
                    style: IconButton.styleFrom(
                      foregroundColor: scheme.primary,
                      backgroundColor: scheme.primaryContainer.withValues(
                        alpha: .45,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                )
              : null,
          actions: actions == null
              ? null
              : [...actions!, const SizedBox(width: 12)],
        ),
        body: SafeArea(
          top: false,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppValues.screenPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (!compactTitle)
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(height: 7),
                            Text(
                              subtitle!,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: scheme.onSurfaceVariant),
                            ),
                          ],
                        ],
                      ),
                    ),
                  Expanded(child: body),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: keyboardVisible || bottom != null
            ? SafeArea(
                minimum: const EdgeInsets.fromLTRB(
                  AppValues.screenPadding,
                  8,
                  AppValues.screenPadding,
                  12,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (keyboardVisible)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          child: Text(l.commonDone),
                        ),
                      ),
                    ?bottom,
                  ],
                ),
              )
            : null,
      ),
    );
  }
}
