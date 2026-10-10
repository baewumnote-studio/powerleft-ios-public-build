import '../../core/widgets/power_visuals.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_environment.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../providers.dart';
import '../home/home_screen.dart';
import '../settings/language_picker.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  Future<void> _finish() async {
    final settings = ref.read(settingsServiceProvider);
    final privacy = ref.read(privacyServiceProvider);
    final ads = ref.read(adServiceProvider);

    await settings.completeOnboarding();
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
    );

    // The first-run onboarding stays interruption-free. After the user enters
    // Home, present any required UMP form and prepare ads for future sessions.
    if (!AppEnvironment.adsDisabledForTesting) {
      unawaited(privacy.ensureConsentForAds().then((_) => ads.preload()));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context), theme = Theme.of(context);
    return PowerBackdrop(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final brand = Text(
                      'PowerLeft',
                      style: theme.textTheme.titleLarge,
                    );
                    final actions = Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          key: const ValueKey('onboarding-language'),
                          tooltip: l.settingsLanguage,
                          onPressed: () => LanguagePicker.show(context, ref),
                          icon: const Icon(Icons.language_rounded),
                        ),
                        const SizedBox(width: 8),
                        if (_page == 0)
                          TextButton(
                            onPressed: _finish,
                            child: Text(l.onboardingSkip),
                          )
                        else
                          const SizedBox(height: 48),
                      ],
                    );
                    if (constraints.maxWidth < 330 ||
                        MediaQuery.textScalerOf(context).scale(16) > 20) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          brand,
                          Align(
                            alignment: Alignment.centerRight,
                            child: actions,
                          ),
                        ],
                      );
                    }
                    return Row(children: [brand, const Spacer(), actions]);
                  },
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (value) => setState(() => _page = value),
                  children: [
                    _Page(title: l.onboarding1Title, body: l.onboarding1Body),
                    _Page(
                      title: l.onboarding2Title,
                      body: l.onboarding2Body,
                      plus: true,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  2,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: _page == i ? 24 : 6,
                    height: 6,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: _page == i
                          ? theme.colorScheme.primary
                          : theme.colorScheme.outline,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      if (_page == 0) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOut,
                        );
                      } else {
                        _finish();
                      }
                    },
                    icon: const Icon(Icons.arrow_forward_rounded, size: 20),
                    label: Text(
                      _page == 0 ? l.onboardingNext : l.onboardingStart,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({required this.title, required this.body, this.plus = false});
  final String title, body;
  final bool plus;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PowerMark(size: 110, plus: plus),
              const SizedBox(height: 35),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                body,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32),
              const PowerLandscape(height: 105),
            ],
          ),
        ),
      ),
    ),
  );
}
