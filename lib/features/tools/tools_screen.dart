import 'package:flutter/material.dart';
import '../../core/utils/formatters.dart';
import '../../core/utils/number_parser.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/power_scaffold.dart';
import '../../domain/models/energy_units.dart';
import '../../l10n/generated/app_localizations.dart';

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({super.key});

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  bool _whToAh = true;
  final _amount = TextEditingController();
  final _voltage = TextEditingController(text: '12');

  @override
  void dispose() {
    _amount.dispose();
    _voltage.dispose();
    super.dispose();
  }

  double? get _result {
    final amount = PowerNumberParser.parseDecimal(
      _amount.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    final voltage = PowerNumberParser.parseDecimal(
      _voltage.text,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    if (amount == null || voltage == null || amount <= 0 || voltage <= 0) {
      return null;
    }
    return _whToAh
        ? EnergyUnits.whToAh(wh: amount, voltage: voltage)
        : EnergyUnits.ahToWh(ah: amount, voltage: voltage);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final result = _result;

    return PowerScaffold(
      title: l.toolsTitle,
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        children: [
          AppCard(
            child: Column(
              children: [
                SegmentedButton<bool>(
                  segments: [
                    ButtonSegment(value: true, label: Text(l.converterWhToAh)),
                    ButtonSegment(value: false, label: Text(l.converterAhToWh)),
                  ],
                  selected: {_whToAh},
                  onSelectionChanged: (set) {
                    setState(() => _whToAh = set.first);
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _amount,
                  onChanged: (_) => setState(() {}),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: _whToAh ? l.converterWh : l.converterAh,
                    suffixText: _whToAh ? 'Wh' : 'Ah',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _voltage,
                  onChanged: (_) => setState(() {}),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: l.converterVoltageV,
                    suffixText: 'V',
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [12, 24, 48]
                      .map(
                        (v) => ActionChip(
                          label: Text('${v}V'),
                          onPressed: () {
                            _voltage.text = v.toString();
                            setState(() {});
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          AppCard(
            child: Column(
              children: [
                Text(
                  l.converterResult,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  result == null
                      ? '—'
                      : '${PowerFormatters.number(result, locale: Localizations.localeOf(context).toLanguageTag(), maxFractionDigits: result >= 100 ? 1 : 2)} ${_whToAh ? 'Ah' : 'Wh'}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 10),
                Text(
                  _whToAh ? l.converterWhToAhFormula : l.converterAhToWhFormula,
                ),
                if (result == null && _amount.text.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    l.converterEnterValues,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Text(
                  l.converterCaveat,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
