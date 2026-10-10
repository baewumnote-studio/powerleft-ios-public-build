import '../../core/widgets/power_visuals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_values.dart';
import '../../core/utils/formatters.dart';
import '../../core/utils/number_parser.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/device_row.dart';
import '../../core/widgets/power_scaffold.dart';
import '../../core/widgets/section_header.dart';
import '../../data/db/app_database.dart';
import '../../domain/models/device_input.dart';
import '../../domain/models/energy_units.dart';
import '../../domain/models/enums.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/localized_labels.dart';
import '../../providers.dart';
import '../appliances/appliance_library_screen.dart';
import '../appliances/device_editor_sheet.dart';
import '../batteries/battery_profiles_screen.dart';
import 'runtime_result_screen.dart';

class RuntimeCalculatorScreen extends ConsumerStatefulWidget {
  const RuntimeCalculatorScreen({
    super.key,
    this.initialSetupId,
    this.initialBatteryProfileId,
    this.initialCapacityWh,
    this.initialChargePercent,
    this.initialConnection,
    this.initialDevices = const [],
    this.initialReserveFloorPercent,
    this.initialCustomEfficiency,
    this.initialMaxContinuousOutputW,
  });

  final String? initialSetupId;
  final String? initialBatteryProfileId;
  final double? initialCapacityWh;
  final double? initialChargePercent;
  final ConnectionType? initialConnection;
  final List<DeviceInput> initialDevices;
  final double? initialReserveFloorPercent;
  final double? initialCustomEfficiency;
  final double? initialMaxContinuousOutputW;

  @override
  ConsumerState<RuntimeCalculatorScreen> createState() =>
      _RuntimeCalculatorScreenState();
}

class _RuntimeCalculatorScreenState
    extends ConsumerState<RuntimeCalculatorScreen> {
  late final TextEditingController _capacity;
  late final TextEditingController _chargeText;
  late final TextEditingController _reserve;
  late final TextEditingController _efficiency;
  late final TextEditingController _maxOutput;
  late double _charge;
  late ConnectionType _connection;
  late String? _batteryProfileId;
  late List<DeviceInput> _devices;
  bool _useKwh = false;
  bool _didFormatInitialValues = false;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsServiceProvider);
    _capacity = TextEditingController(
      text: widget.initialCapacityWh?.toStringAsFixed(0) ?? '',
    );
    _charge = widget.initialChargePercent ?? 100;
    _chargeText = TextEditingController(
      text: _charge.toStringAsFixed(
        _charge.truncateToDouble() == _charge ? 0 : 1,
      ),
    );
    _connection =
        widget.initialConnection ??
        ConnectionTypeX.fromWire(settings.defaultConnectionType);
    _batteryProfileId = widget.initialBatteryProfileId;
    _devices = [...widget.initialDevices];
    _reserve = TextEditingController(
      text:
          (widget.initialReserveFloorPercent ??
                  settings.defaultReserveFloorPercent)
              .toStringAsFixed(0),
    );
    _efficiency = TextEditingController(
      text: widget.initialCustomEfficiency == null
          ? ''
          : (widget.initialCustomEfficiency! * 100).toStringAsFixed(0),
    );
    _maxOutput = TextEditingController(
      text: widget.initialMaxContinuousOutputW?.toStringAsFixed(0) ?? '',
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didFormatInitialValues) return;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final capacity = widget.initialCapacityWh;
    if (capacity != null) {
      _capacity.text = PowerFormatters.inputNumber(
        capacity,
        locale: locale,
        maxFractionDigits: 3,
      );
    }
    _chargeText.text = PowerFormatters.inputNumber(
      _charge,
      locale: locale,
      maxFractionDigits: 1,
    );
    final reserve = PowerNumberParser.parseDecimal(
      _reserve.text,
      locale: locale,
    );
    if (reserve != null) {
      _reserve.text = PowerFormatters.inputNumber(
        reserve,
        locale: locale,
        maxFractionDigits: 1,
      );
    }
    final customEfficiency = widget.initialCustomEfficiency;
    if (customEfficiency != null) {
      _efficiency.text = PowerFormatters.inputNumber(
        customEfficiency * 100,
        locale: locale,
        maxFractionDigits: 1,
      );
    }
    final maxOutput = widget.initialMaxContinuousOutputW;
    if (maxOutput != null) {
      _maxOutput.text = PowerFormatters.inputNumber(
        maxOutput,
        locale: locale,
        maxFractionDigits: 1,
      );
    }
    _didFormatInitialValues = true;
  }

  @override
  void dispose() {
    _capacity.dispose();
    _chargeText.dispose();
    _reserve.dispose();
    _efficiency.dispose();
    _maxOutput.dispose();
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

  Future<void> _chooseSavedBattery() async {
    final selected = await Navigator.of(context).push<BatteryProfile>(
      MaterialPageRoute(
        builder: (_) => const BatteryProfilesScreen(selectionMode: true),
      ),
    );
    if (!mounted || selected == null) return;
    setState(() {
      _batteryProfileId = selected.id;
      final locale = Localizations.localeOf(context).toLanguageTag();
      final displayCapacity = _useKwh
          ? EnergyUnits.whToKwh(selected.capacityWh)
          : selected.capacityWh;
      _capacity.text = PowerFormatters.inputNumber(
        displayCapacity,
        locale: locale,
        maxFractionDigits: _useKwh ? 3 : 1,
      );
      _charge = selected.currentChargePercent.clamp(0, 100).toDouble();
      _chargeText.text = PowerFormatters.inputNumber(
        _charge,
        locale: locale,
        maxFractionDigits: 1,
      );
      _connection = ConnectionTypeX.fromWire(selected.defaultConnectionType);
      _maxOutput.text = selected.maxContinuousOutputW == null
          ? ''
          : PowerFormatters.inputNumber(
              selected.maxContinuousOutputW!,
              locale: locale,
              maxFractionDigits: 1,
            );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).batteryProfileApplied),
      ),
    );
  }

  void _setCapacityUnit(bool useKwh) {
    if (useKwh == _useKwh) return;

    final locale = Localizations.localeOf(context).toLanguageTag();
    final raw = PowerNumberParser.parseDecimal(_capacity.text, locale: locale);

    setState(() {
      if (raw != null && raw >= 0) {
        final wh = _useKwh ? EnergyUnits.kwhToWh(raw) : raw;
        final converted = useKwh ? EnergyUnits.whToKwh(wh) : wh;

        _capacity.text = PowerFormatters.inputNumber(
          converted,
          locale: locale,
          maxFractionDigits: useKwh ? 3 : 1,
        );
      }
      _useKwh = useKwh;
    });
  }

  double? _capacityWh() {
    final raw = PowerNumberParser.parseDecimal(
      _capacity.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    if (raw == null) return null;
    return _useKwh ? EnergyUnits.kwhToWh(raw) : raw;
  }

  Future<void> _calculate() async {
    final l = AppLocalizations.of(context);
    final capacity = _capacityWh();
    if (capacity == null ||
        capacity <= 0 ||
        capacity > AppValues.maxCapacityWh) {
      _showError(l.errorCapacityRange);
      return;
    }
    if (_devices.isEmpty) {
      _showError(l.errorNoDevices);
      return;
    }
    final charge = PowerNumberParser.parseDecimal(
      _chargeText.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    if (charge == null || charge < 0 || charge > 100) {
      _showError(l.errorChargeRange);
      return;
    }
    final reserve = PowerNumberParser.parseDecimal(
      _reserve.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    if (reserve == null || reserve < 0 || reserve > 50) {
      _showError(l.errorReserveRange);
      return;
    }
    final efficiencyPct = PowerNumberParser.parseDecimal(
      _efficiency.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    if (_efficiency.text.trim().isNotEmpty &&
        (efficiencyPct == null || efficiencyPct < 50 || efficiencyPct > 99)) {
      _showError(l.errorEfficiencyRange);
      return;
    }
    final maxOutput = PowerNumberParser.parseDecimal(
      _maxOutput.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    if (_maxOutput.text.trim().isNotEmpty &&
        (maxOutput == null || maxOutput <= 0)) {
      _showError(l.errorMaxOutputRange);
      return;
    }

    try {
      final result = ref
          .read(calculationEngineProvider)
          .runtime(
            capacityWh: capacity,
            chargePercent: charge,
            defaultConnection: _connection,
            devices: _devices,
            customReserveFloorPercent: reserve,
            customTypicalEfficiency: efficiencyPct == null
                ? null
                : efficiencyPct / 100,
            maxContinuousOutputW: maxOutput,
          );
      await ref.read(settingsServiceProvider).registerMeaningfulCalculation();
      HapticFeedback.lightImpact();
      if (!mounted) return;
      await Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (_) => RuntimeResultScreen(
            setupId: widget.initialSetupId,
            batteryProfileId: _batteryProfileId,
            result: result,
            capacityWh: capacity,
            chargePercent: charge,
            connection: _connection,
            devices: _devices,
            reserveFloorPercent: reserve,
            customEfficiency: efficiencyPct == null
                ? null
                : efficiencyPct / 100,
            maxContinuousOutputW: maxOutput,
          ),
        ),
      );
    } on FormatException {
      _showError(l.errorCalculation);
    }
  }

  void _showError(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final totalAverage = _devices.fold<double>(
      0,
      (sum, d) => sum + d.averageWatts,
    );
    return PowerScaffold(
      title: l.runtimeTitle,
      subtitle: l.designRuntimeHelp,
      bottom: FilledButton.icon(
        key: const ValueKey('runtime-calculate'),
        onPressed: _calculate,
        icon: const Icon(Icons.calculate_outlined, size: 21),
        label: Text(l.runtimeCalculate),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: _chooseSavedBattery,
              icon: const Icon(Icons.bookmark_border_rounded, size: 17),
              label: Text(l.batteryProfileChoose),
            ),
          ),
          PowerInputRow(
            icon: Icons.battery_5_bar_rounded,
            label: l.runtimeCapacity,
            controlWidth: 140,
            control: TextField(
              key: const ValueKey('runtime-capacity-input'),
              controller: _capacity,
              textAlign: TextAlign.right,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) {
                if (_batteryProfileId != null) {
                  setState(() => _batteryProfileId = null);
                }
              },
              decoration: InputDecoration(
                hintText: '0',
                suffixIcon: PopupMenuButton<bool>(
                  tooltip: l.runtimeCapacity,
                  onSelected: _setCapacityUnit,
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: false, child: Text('Wh')),
                    PopupMenuItem(value: true, child: Text('kWh')),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _useKwh ? 'kWh' : 'Wh',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Icon(Icons.expand_more, size: 14),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          PowerInputRow(
            icon: Icons.bolt_rounded,
            label: l.runtimeCharge,
            control: TextField(
              controller: _chargeText,
              textAlign: TextAlign.right,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (raw) {
                final parsed = PowerNumberParser.parseDecimal(
                  raw,
                  locale: locale,
                );
                if (parsed != null && parsed >= 0 && parsed <= 100) {
                  setState(() => _charge = parsed);
                }
              },
              decoration: const InputDecoration(suffixText: '%'),
            ),
          ),
          const SizedBox(height: 8),
          PowerInputRow(
            icon: Icons.power_outlined,
            label: l.runtimeConnection,
            controlWidth: 140,
            control: DropdownButtonFormField<ConnectionType>(
              key: ValueKey(_connection),
              initialValue: _connection,
              isExpanded: true,
              items: ConnectionType.values
                  .map(
                    (c) => DropdownMenuItem(
                      value: c,
                      child: Text(
                        c.shortLabel,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _connection = value;
                    _batteryProfileId = null;
                  });
                }
              },
            ),
          ),
          const SizedBox(height: 8),
          PowerInputRow(
            icon: Icons.shield_outlined,
            label: l.runtimeReserve,
            control: TextField(
              controller: _reserve,
              textAlign: TextAlign.right,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(suffixText: '%'),
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
                  key: const ValueKey('runtime-add-device'),
                  onPressed: _addDevice,
                  icon: const Icon(Icons.add_circle_outline, size: 20),
                  label: Text(l.runtimeAddDevice),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text(
              l.runtimeAdvanced,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            children: [
              AppCard(
                child: Column(
                  children: [
                    Text(
                      l.runtimeReserveHelp,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _efficiency,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: l.runtimeEfficiencyPercent,
                        suffixText: '%',
                        hintText: l.runtimeAutomatic,
                        helperText: l.runtimeEfficiencyHelp,
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _maxOutput,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: (_) {
                        if (_batteryProfileId != null) {
                          setState(() => _batteryProfileId = null);
                        }
                      },
                      decoration: InputDecoration(
                        labelText: l.runtimeMaxOutput,
                        suffixText: 'W',
                        helperText: l.runtimeMaxOutputHelp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
