import 'package:flutter/material.dart';
import '../../core/constants/app_values.dart';
import '../../core/utils/formatters.dart';
import '../../core/utils/number_parser.dart';
import '../../domain/models/device_input.dart';
import '../../domain/models/enums.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/localized_labels.dart';

class DeviceEditorSheet extends StatefulWidget {
  const DeviceEditorSheet({
    super.key,
    this.initial,
    this.title,
    this.lockName = false,
    this.lockCategory = false,
  });

  final DeviceInput? initial;
  final String? title;
  final bool lockName;
  final bool lockCategory;

  static Future<DeviceInput?> show(
    BuildContext context, {
    DeviceInput? initial,
    String? title,
    bool lockName = false,
    bool lockCategory = false,
  }) {
    return showModalBottomSheet<DeviceInput>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => DeviceEditorSheet(
        initial: initial,
        title: title,
        lockName: lockName,
        lockCategory: lockCategory,
      ),
    );
  }

  @override
  State<DeviceEditorSheet> createState() => _DeviceEditorSheetState();
}

class _DeviceEditorSheetState extends State<DeviceEditorSheet> {
  late final TextEditingController _name;
  late final TextEditingController _watts;
  late final TextEditingController _customPercent;
  late UsagePattern _pattern;
  ConnectionType? _override;
  late bool _surge;
  late bool _medical;
  late String _category;
  bool _submitted = false;
  bool _didFormatInitialValues = false;

  @override
  void initState() {
    super.initState();
    final d = widget.initial;
    _name = TextEditingController(text: d?.name ?? '');
    _watts = TextEditingController(
      text: d == null ? '' : d.watts.toStringAsFixed(d.watts % 1 == 0 ? 0 : 1),
    );
    _customPercent = TextEditingController(
      text: d?.customUsageFactor == null
          ? '50'
          : (d!.customUsageFactor! * 100).round().toString(),
    );
    _pattern = d?.usagePattern ?? UsagePattern.alwaysOn;
    _override = d?.connectionOverride;
    _surge = d?.hasStartupSurge ?? false;
    _medical = d?.isMedicalRelated ?? false;
    _category = d?.category ?? 'other';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didFormatInitialValues) return;
    final d = widget.initial;
    if (d != null) {
      final locale = Localizations.localeOf(context).toLanguageTag();
      _watts.text = PowerFormatters.inputNumber(
        d.watts,
        locale: locale,
        maxFractionDigits: 2,
      );
      final customFactor = d.customUsageFactor;
      if (customFactor != null) {
        _customPercent.text = PowerFormatters.inputNumber(
          customFactor * 100,
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
    _watts.dispose();
    _customPercent.dispose();
    super.dispose();
  }

  void _save() {
    setState(() => _submitted = true);
    final watts = PowerNumberParser.parseDecimal(
      _watts.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    final customPct = PowerNumberParser.parseDecimal(
      _customPercent.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    if (_name.text.trim().isEmpty ||
        watts == null ||
        watts <= 0 ||
        watts > AppValues.maxDeviceWatts) {
      return;
    }
    if (_pattern == UsagePattern.custom &&
        (customPct == null || customPct < 5 || customPct > 100)) {
      setState(() {});
      return;
    }
    Navigator.pop(
      context,
      DeviceInput(
        name: _name.text.trim(),
        watts: watts,
        usagePattern: _pattern,
        customUsageFactor: _pattern == UsagePattern.custom
            ? customPct! / 100
            : null,
        connectionOverride: _override,
        hasStartupSurge: _surge,
        isMedicalRelated: _medical,
        category: _category,
        sourceApplianceId: widget.initial?.sourceApplianceId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final watts = PowerNumberParser.parseDecimal(
      _watts.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    final invalidName = _submitted && _name.text.trim().isEmpty;
    final invalidW =
        _submitted &&
        (watts == null || watts <= 0 || watts > AppValues.maxDeviceWatts);
    final custom = PowerNumberParser.parseDecimal(
      _customPercent.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    final invalidCustom =
        _submitted &&
        _pattern == UsagePattern.custom &&
        (custom == null || custom < 5 || custom > 100);

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.title ?? l.deviceCustom,
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
            readOnly: widget.lockName,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: l.deviceName,
              errorText: invalidName ? l.errorNameRequired : null,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _watts,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: l.deviceWattage,
              suffixText: 'W',
              errorText: invalidW ? l.errorWattageRange : null,
            ),
          ),
          const SizedBox(height: 16),
          Text(l.deviceUsage, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          DropdownButtonFormField<UsagePattern>(
            key: ValueKey(_pattern),
            initialValue: _pattern,
            items: UsagePattern.values
                .map(
                  (p) => DropdownMenuItem(
                    value: p,
                    child: Text(localizedUsage(l, p)),
                  ),
                )
                .toList(),
            onChanged: (v) => setState(() => _pattern = v ?? _pattern),
          ),
          if (_pattern == UsagePattern.custom) ...[
            const SizedBox(height: 12),
            TextField(
              controller: _customPercent,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: l.customPercentLabel,
                suffixText: '%',
                errorText: invalidCustom ? '5–100%' : null,
              ),
            ),
          ],
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            key: ValueKey(_category),
            initialValue:
                const {
                  'camping',
                  'home_backup',
                  'outdoor',
                  'work',
                  'high_draw',
                  'other',
                }.contains(_category)
                ? _category
                : 'other',
            decoration: InputDecoration(labelText: l.deviceCategory),
            items: [
              DropdownMenuItem(
                value: 'camping',
                child: Text(l.categoryCamping),
              ),
              DropdownMenuItem(
                value: 'home_backup',
                child: Text(l.categoryHomeBackup),
              ),
              DropdownMenuItem(
                value: 'outdoor',
                child: Text(l.categoryOutdoor),
              ),
              DropdownMenuItem(value: 'work', child: Text(l.categoryWork)),
              DropdownMenuItem(
                value: 'high_draw',
                child: Text(l.categoryHighDraw),
              ),
              DropdownMenuItem(value: 'other', child: Text(l.categoryOther)),
            ],
            onChanged: widget.lockCategory
                ? null
                : (value) {
                    if (value != null) {
                      setState(() => _category = value);
                    }
                  },
          ),
          const SizedBox(height: 16),
          Text(
            l.runtimeConnection,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            key: ValueKey(_override?.wireValue ?? 'DEFAULT'),
            isExpanded: true,
            initialValue: _override?.wireValue ?? 'DEFAULT',
            items: [
              DropdownMenuItem<String>(
                value: 'DEFAULT',
                child: Text(l.deviceConnectionDefault),
              ),
              ...ConnectionType.values.map(
                (c) => DropdownMenuItem<String>(
                  value: c.wireValue,
                  child: Text(c.shortLabel),
                ),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _override = value == null || value == 'DEFAULT'
                    ? null
                    : ConnectionTypeX.fromWire(value);
              });
            },
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l.deviceStartupSurge),
            value: _surge,
            onChanged: (v) => setState(() => _surge = v),
          ),
          if (_medical)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(l.deviceCpapHint),
            ),
          Text(l.deviceLabelHint, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 20),
          FilledButton(
            key: const ValueKey('device-editor-save'),
            onPressed: _save,
            child: Text(l.commonSave),
          ),
        ],
      ),
    );
  }
}
