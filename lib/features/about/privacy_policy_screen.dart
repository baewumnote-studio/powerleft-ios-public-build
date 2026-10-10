import 'package:flutter/material.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/power_scaffold.dart';
import '../../l10n/generated/app_localizations.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return PowerScaffold(
      title: l.privacyPolicyTitle,
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        children: [
          _PolicySection(
            title: l.privacyPolicyLocalTitle,
            body: l.privacyPolicyLocalBody,
          ),
          const SizedBox(height: 12),
          _PolicySection(
            title: l.privacyPolicyAdsTitle,
            body: l.privacyPolicyAdsBody,
          ),
          const SizedBox(height: 12),
          _PolicySection(
            title: l.privacyPolicyConsentTitle,
            body: l.privacyPolicyConsentBody,
          ),
          const SizedBox(height: 12),
          _PolicySection(
            title: l.privacyPolicyTrackingTitle,
            body: l.privacyPolicyTrackingBody,
          ),
          const SizedBox(height: 12),
          _PolicySection(
            title: l.privacyPolicyRetentionTitle,
            body: l.privacyPolicyRetentionBody,
          ),
          const SizedBox(height: 12),
          _PolicySection(
            title: l.privacyPolicyChildrenTitle,
            body: l.privacyPolicyChildrenBody,
          ),
          const SizedBox(height: 12),
          _PolicySection(
            title: l.privacyPolicyContactTitle,
            body: l.privacyPolicyContactBody,
          ),
        ],
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  const _PolicySection({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(body),
        ],
      ),
    );
  }
}
