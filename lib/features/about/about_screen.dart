import 'package:flutter/material.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/power_scaffold.dart';
import '../../l10n/generated/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return PowerScaffold(
      title: l.aboutTitle,
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        children: [
          _Section(
            title: l.aboutLocalDataTitle,
            body: l.aboutLocalDataBody,
            icon: Icons.phone_iphone_rounded,
          ),
          const SizedBox(height: 12),
          _Section(
            title: l.aboutEstimateTitle,
            body: '${l.aboutEstimateBody}\n\n${l.aboutNoGuarantee}',
            icon: Icons.calculate_outlined,
          ),
          const SizedBox(height: 12),
          _Section(
            title: l.aboutMedicalTitle,
            body: l.aboutMedicalBody,
            icon: Icons.medical_services_outlined,
          ),
          const SizedBox(height: 12),
          _Section(
            title: l.aboutPrivacyTitle,
            body: '${l.aboutPrivacyBody}\n\n${l.adNoImpact}',
            icon: Icons.privacy_tip_outlined,
          ),
          const SizedBox(height: 12),
          AppCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.code_rounded),
              title: Text(l.aboutOpenSourceLicenses),
              subtitle: Text(l.aboutOpenSourceBody),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showLicensePage(
                context: context,
                applicationName: 'PowerLeft',
                applicationVersion: '1.0.0',
              ),
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            child: Text(
              l.disclaimerFull,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.body, required this.icon});

  final String title;
  final String body;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
