import 'package:flutter/material.dart';
import '../../core/constants/app_values.dart';
import '../../core/utils/formatters.dart';
import '../../core/utils/number_parser.dart';
import '../../data/db/app_database.dart';
import '../../domain/models/enums.dart';
import '../../l10n/generated/app_localizations.dart';

class BatteryProfileDraft {
  const BatteryProfileDraft({
    required this.name,
    required this.capacityWh,
    required this.connection,
    required this.chargePercent,
    this.maxContinuousOutputW,
  });

  final String name;
  final double capacityWh;
  final ConnectionType connection;
  final double chargePercent;
  final double? maxContinuousOutputW;
}

class BatteryProfileEditorSheet extends StatefulWidget {
  const BatteryProfileEditorSheet({super.key, this.initial});
  final BatteryProfile? initial;

  static Future<BatteryProfileDraft?> show(
    BuildContext context, {
    BatteryProfile? initial,
  }) {
    return showModalBottomSheet<BatteryProfileDraft>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) => BatteryProfileEditorSheet(initial: initial),
    );
  }

  @override
  State<BatteryProfileEditorSheet> createState() =>
      _BatteryProfileEditorSheetState();
}

class _BatteryProfileEditorSheetState extends State<BatteryProfileEditorSheet> {
  late final TextEditingController _name;
  late final TextEditingController _capacity;
  late final TextEditingController _charge;
  late final TextEditingController _maxOutput;
  late ConnectionType _connection;
  bool _submitted = false;
  bool _didFormatInitialValues = false;

  @override
  void initState() {
    super.initState();
    final b = widget.initial;
    _name = TextEditingController(text: b?.name ?? '');
    _capacity = TextEditingController(
      text: b?.capacityWh.toStringAsFixed(0) ?? '',
    );
    _charge = TextEditingController(
      text: b?.currentChargePercent.toStringAsFixed(0) ?? '100',
    );
    _maxOutput = TextEditingController(
      text: b?.maxContinuousOutputW?.toStringAsFixed(0) ?? '',
    );
    _connection = b == null
        ? ConnectionType.ac
        : ConnectionTypeX.fromWire(b.defaultConnectionType);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didFormatInitialValues) return;
    final b = widget.initial;
    if (b != null) {
      final locale = Localizations.localeOf(context).toLanguageTag();
      _capacity.text = PowerFormatters.inputNumber(
        b.capacityWh,
        locale: locale,
        maxFractionDigits: 3,
      );
      _charge.text = PowerFormatters.inputNumber(
        b.currentChargePercent,
        locale: locale,
        maxFractionDigits: 1,
      );
      if (b.maxContinuousOutputW != null) {
        _maxOutput.text = PowerFormatters.inputNumber(
          b.maxContinuousOutputW!,
          locale: locale,
          maxFractionDigits: 1,
        );
      }
    }
    _didFormatInitialValues = true;
  }

  @override
  void dispose() {
    _name.dispose();
    _capacity.dispose();
    _charge.dispose();
    _maxOutput.dispose();
    super.dispose();
  }

  void _save() {
    setState(() => _submitted = true);
    final capacity = PowerNumberParser.parseDecimal(
      _capacity.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    final charge = PowerNumberParser.parseDecimal(
      _charge.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    final maxOutput = PowerNumberParser.parseDecimal(
      _maxOutput.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );

    if (_name.text.trim().isEmpty ||
        capacity == null ||
        capacity <= 0 ||
        capacity > AppValues.maxCapacityWh ||
        charge == null ||
        charge < 0 ||
        charge > 100 ||
        (_maxOutput.text.trim().isNotEmpty &&
            (maxOutput == null || maxOutput <= 0))) {
      return;
    }

    Navigator.pop(
      context,
      BatteryProfileDraft(
        name: _name.text.trim(),
        capacityWh: capacity,
        connection: _connection,
        chargePercent: charge,
        maxContinuousOutputW: maxOutput,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final capacity = PowerNumberParser.parseDecimal(
      _capacity.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    final charge = PowerNumberParser.parseDecimal(
      _charge.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    final maxOutput = PowerNumberParser.parseDecimal(
      _maxOutput.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    final nameError = _submitted && _name.text.trim().isEmpty;
    final capacityError =
        _submitted &&
        (capacity == null ||
            capacity <= 0 ||
            capacity > AppValues.maxCapacityWh);
    final chargeError =
        _submitted && (charge == null || charge < 0 || charge > 100);
    final outputError =
        _submitted &&
        _maxOutput.text.trim().isNotEmpty &&
        (maxOutput == null || maxOutput <= 0);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.initial == null ? l.batteryProfileAdd : l.commonEdit,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _name,
            maxLength: 80,
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: l.batteryProfileName,
              errorText: nameError ? l.errorNameRequired : null,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _capacity,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: l.batteryProfileCapacity,
              suffixText: 'Wh',
              errorText: capacityError ? l.errorCapacityRange : null,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _charge,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: l.batteryProfileCharge,
              suffixText: '%',
              errorText: chargeError ? l.errorChargeRange : null,
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<ConnectionType>(
            key: ValueKey(_connection),
            initialValue: _connection,
            decoration: InputDecoration(labelText: l.runtimeConnection),
            items: ConnectionType.values
                .map(
                  (c) => DropdownMenuItem(value: c, child: Text(c.shortLabel)),
                )
                .toList(),
            onChanged: (v) => setState(() => _connection = v ?? _connection),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _maxOutput,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: l.batteryProfileMaxOutput,
              suffixText: 'W',
              hintText: l.fieldOptional,
              errorText: outputError ? l.errorMaxOutputRange : null,
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(onPressed: _save, child: Text(l.commonSave)),
        ],
      ),
    );
  }
}
