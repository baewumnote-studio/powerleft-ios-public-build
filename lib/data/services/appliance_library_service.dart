import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/appliance_preset.dart';

class ApplianceLibraryService {
  const ApplianceLibraryService();

  Future<List<AppliancePreset>> load() async {
    final raw = await rootBundle.loadString(
      'assets/data/appliance_library.json',
    );
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final items = (decoded['items'] as List).cast<Map<String, dynamic>>();
    return items.map(AppliancePreset.fromJson).toList(growable: false);
  }
}
