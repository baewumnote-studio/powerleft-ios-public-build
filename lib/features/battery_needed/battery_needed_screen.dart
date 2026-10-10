import '../../core/widgets/power_visuals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_values.dart';
import '../../core/utils/formatters.dart';
import '../../core/utils/number_parser.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/connection_selector.dart';
import '../../core/widgets/device_row.dart';
import '../../core/widgets/power_scaffold.dart';
import '../../core/widgets/section_header.dart';
import '../../domain/models/device_input.dart';
import '../../domain/models/enums.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/localized_labels.dart';
import '../../providers.dart';
import '../appliances/appliance_library_screen.dart';
import '../appliances/device_editor_sheet.dart';
import 'battery_needed_result_screen.dart';

class BatteryNeededScreen extends ConsumerStatefulWidget {
  const BatteryNeededScreen({
    super.key,
    this.initialSetupId,
    this.initialConnection,
    this.initialDevices = const [],
    this.initialDesiredRuntimeHours,
  });

  final String? initialSetupId;
  final ConnectionType? initialConnection;
  final List<DeviceInput> initialDevices;
  final double? initialDesiredRuntimeHours;

  @override
  ConsumerState<BatteryNeededScreen> createState() =>
      _BatteryNeededScreenState();
}

class _BatteryNeededScreenState extends ConsumerState<BatteryNeededScreen> {
  late ConnectionType _connection;
  late List<DeviceInput> _devices;
  late final TextEditingController _hours;
  bool _didFormatInitialValues = false;

  @override
  void initState() {
    super.initState();
    _connection =
        widget.initialConnection ??
        ConnectionTypeX.fromWire(
          ref.read(settingsServiceProvider).defaultConnectionType,
        );
    _devices = [...widget.initialDevices];
    _hours = TextEditingController(
      text:
          widget.initialDesiredRuntimeHours
              ?.toStringAsFixed(1)
              .replaceAll('.0', '') ??
          '',
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didFormatInitialValues) return;
    final hours = widget.initialDesiredRuntimeHours;
    if (hours != null) {
      _hours.text = PowerFormatters.inputNumber(
        hours,
        locale: Localizations.localeOf(context).toLanguageTag(),
        maxFractionDigits: 2,
      );
    }
    _didFormatInitialValues = true;
  }

  @override
  void dispose() {
    _hours.dispose();
    super.dispose();
  }

  Future<void> _editDevice(int index) async {
    final current = _devices[index];
    final l = AppLocalizations.of(context);
    final isBuiltIn =
        current.sourceApplianceId != null &&
        current.sourceApplianceId!.isNotEmpty &&
        !current.sourceApplianceId!.contains('-');

    final localizedInitial = isBuiltIn
        ? current.copyWith(
            name: localizedDeviceId(l, current.sourceApplianceId, current.name),
          )
        : current;

    final edited = await DeviceEditorSheet.show(
      context,
      initial: localizedInitial,
      title: localizedInitial.name,
      lockName: isBuiltIn,
      lockCategory: isBuiltIn,
    );
    if (edited == null || !mounted) return;

    setState(() {
      _devices[index] = edited;
    });
  }

  Future<void> _addDevice() async {
    final result = await Navigator.of(context).push<DeviceInput>(
      MaterialPageRoute(builder: (_) => const ApplianceLibraryScreen()),
    );
    if (!mounted || result == null) return;
    setState(() => _devices.add(result));
  }

  Future<void> _calculate() async {
    final l = AppLocalizations.of(context);
    final hours = PowerNumberParser.parseDecimal(
      _hours.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    if (hours == null || hours <= 0 || hours > AppValues.maxRuntimeHours) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.errorRuntimeRange)));
      return;
    }
    if (_devices.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.errorNoDevices)));
      return;
    }

    try {
      final result = ref
          .read(calculationEngineProvider)
          .batteryNeeded(
            desiredRuntimeHours: hours,
            defaultConnection: _connection,
            devices: _devices,
          );
      await ref.read(settingsServiceProvider).registerMeaningfulCalculation();
      HapticFeedback.lightImpact();

      if (!mounted) return;
      await Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (_) => BatteryNeededResultScreen(
            setupId: widget.initialSetupId,
            result: result,
            desiredRuntimeHours: hours,
            connection: _connection,
            devices: _devices,
          ),
        ),
      );
    } on FormatException {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.errorCalculation)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final totalAverage = _devices.fold<double>(
      0,
      (sum, d) => sum + d.averageWatts,
    );
    void step(double change) {
      final value =
          (PowerNumberParser.parseDecimal(_hours.text, locale: locale) ?? 8) +
          change;
      if (value > 0 && value <= AppValues.maxRuntimeHours) {
        _hours.text = PowerFormatters.inputNumber(
          value,
          locale: locale,
          maxFractionDigits: 2,
        );
        setState(() {});
      }
    }

    return PowerScaffold(
      title: l.neededTitle,
      subtitle: l.designNeededHelp,
      bottom: FilledButton.icon(
        key: const ValueKey('needed-calculate'),
        onPressed: _calculate,
        icon: const Icon(Icons.battery_charging_full_rounded, size: 21),
        label: Text(l.neededCalculate),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const PowerIconTile(icon: Icons.schedule_rounded),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l.neededDesiredRuntime,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    IconButton(
                      key: const ValueKey('needed-decrement'),
                      tooltip: '−1 ${l.commonHoursShort}',
                      onPressed: () => step(-1),
                      icon: const Icon(Icons.remove_rounded),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        key: const ValueKey('needed-hours-input'),
                        controller: _hours,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: l.neededHoursHint,
                          suffixText: l.commonHoursShort,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      key: const ValueKey('needed-increment'),
                      tooltip: '+1 ${l.commonHoursShort}',
                      onPressed: () => step(1),
                      icon: const Icon(Icons.add_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [4, 8, 12, 24]
                      .map(
                        (h) => ActionChip(
                          label: Text('$h ${l.commonHoursShort}'),
                          onPressed: () {
                            _hours.text = h.toString();
                            setState(() {});
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const PowerIconTile(icon: Icons.power_outlined, size: 36),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l.runtimeConnection,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                ConnectionSelector(
                  value: _connection,
                  onChanged: (value) => setState(() => _connection = value),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SectionHeader(
            l.runtimeDevices,
            trailing: Text(
              PowerFormatters.watts(
                totalAverage,
                locale: locale,
                maxFractionDigits: 0,
              ),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 10),
          AppCard(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_devices.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      l.errorNoDevices,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ...List.generate(
                  _devices.length,
                  (i) => DeviceRow(
                    device: _devices[i],
                    onTap: () => _editDevice(i),
                    onDelete: () => setState(() => _devices.removeAt(i)),
                  ),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  key: const ValueKey('needed-add-device'),
                  onPressed: _addDevice,
                  icon: const Icon(Icons.add_circle_outline, size: 20),
                  label: Text(l.runtimeAddDevice),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(
            l.disclaimerShort,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
