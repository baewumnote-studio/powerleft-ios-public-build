import 'package:flutter/material.dart';
import '../../domain/models/device_input.dart';
import '../utils/formatters.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/localized_labels.dart';
import 'power_visuals.dart';

IconData deviceIcon(String? id, String category) {
  return switch (id) {
    'portable_fridge' || 'refrigerator' || 'freezer' => Icons.kitchen_outlined,
    'led_light' || 'work_light' => Icons.lightbulb_outline_rounded,
    'fan' => Icons.air_rounded,
    'laptop' || 'desktop_pc' || 'portable_monitor' => Icons.laptop_mac_outlined,
    'phone_charger' => Icons.phone_iphone_rounded,
    'cpap' => Icons.medical_services_outlined,
    'wifi_router' || 'modem' => Icons.router_outlined,
    'electric_blanket' => Icons.waves_rounded,
    _ => switch (category) {
      'camping' => Icons.park_outlined,
      'home_backup' => Icons.home_outlined,
      'outdoor' => Icons.landscape_outlined,
      'work' => Icons.work_outline_rounded,
      'high_draw' => Icons.bolt_outlined,
      _ => Icons.power_outlined,
    },
  };
}

class DeviceRow extends StatelessWidget {
  const DeviceRow({super.key, required this.device, this.onTap, this.onDelete});
  final DeviceInput device;
  final VoidCallback? onTap, onDelete;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context),
        theme = Theme.of(context),
        locale = Localizations.localeOf(context).toLanguageTag();
    final row = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
        child: Row(
          children: [
            PowerIconTile(
              icon: device.isMedicalRelated
                  ? Icons.medical_services_outlined
                  : deviceIcon(device.sourceApplianceId, device.category),
              size: 36,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizedDeviceId(l, device.sourceApplianceId, device.name),
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${PowerFormatters.watts(device.watts, locale: locale)} · ${localizedUsage(l, device.usagePattern)}',
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              PowerFormatters.watts(
                device.averageWatts,
                locale: locale,
                maxFractionDigits: 0,
              ),
              style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            if (onTap != null) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ],
        ),
      ),
    );
    if (onDelete == null) return row;
    return Dismissible(
      key: ValueKey('${device.name}-${device.hashCode}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(Icons.delete_outline, color: theme.colorScheme.error),
      ),
      onDismissed: (_) => onDelete!(),
      child: row,
    );
  }
}
