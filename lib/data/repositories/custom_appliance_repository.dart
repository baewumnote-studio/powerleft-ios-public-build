import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/device_input.dart';
import '../../domain/models/enums.dart';
import '../../domain/models/power_limits.dart';
import '../db/app_database.dart';

class CustomApplianceRepository {
  CustomApplianceRepository(this.db);
  final AppDatabase db;
  static final _uuid = Uuid();

  Stream<List<CustomAppliance>> watchAll() {
    return (db.select(
      db.customAppliances,
    )..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();
  }

  Future<void> upsert({String? id, required DeviceInput device}) async {
    final trimmedName = device.name.trim();
    if (trimmedName.isEmpty || trimmedName.length > PowerLimits.nameMaxLength) {
      throw ArgumentError.value(device.name, 'name', 'invalid device name');
    }
    if (device.watts <= PowerLimits.deviceWattsMinExclusive ||
        device.watts > PowerLimits.deviceWattsMax) {
      throw RangeError.value(
        device.watts,
        'watts',
        'must be greater than ${PowerLimits.deviceWattsMinExclusive} and at most ${PowerLimits.deviceWattsMax}',
      );
    }
    final usageFactor = device.usageFactor;
    if (usageFactor < PowerLimits.usageFactorMin ||
        usageFactor > PowerLimits.usageFactorMax) {
      throw RangeError.value(
        usageFactor,
        'usageFactor',
        'must be between ${PowerLimits.usageFactorMin} and ${PowerLimits.usageFactorMax}',
      );
    }

    final now = DateTime.now().millisecondsSinceEpoch;
    final existing = id == null
        ? null
        : await (db.select(
            db.customAppliances,
          )..where((t) => t.id.equals(id))).getSingleOrNull();
    final rowId = id ?? _uuid.v4();
    await db
        .into(db.customAppliances)
        .insertOnConflictUpdate(
          CustomAppliancesCompanion(
            id: Value(rowId),
            name: Value(trimmedName),
            watts: Value(device.watts),
            usagePattern: Value(device.usagePattern.wireValue),
            customUsageFactor: Value(device.customUsageFactor),
            category: Value(device.category),
            connectionOverride: Value(device.connectionOverride?.wireValue),
            hasStartupSurge: Value(device.hasStartupSurge),
            isMedicalRelated: Value(device.isMedicalRelated),
            createdAt: Value(existing?.createdAt ?? now),
            updatedAt: Value(now),
          ),
        );
  }

  Future<void> delete(String id) =>
      (db.delete(db.customAppliances)..where((t) => t.id.equals(id))).go();

  DeviceInput toDeviceInput(CustomAppliance row) {
    return DeviceInput(
      name: row.name,
      watts: row.watts,
      usagePattern: UsagePatternX.fromWire(row.usagePattern),
      customUsageFactor: row.customUsageFactor,
      connectionOverride: row.connectionOverride == null
          ? null
          : ConnectionTypeX.fromWire(row.connectionOverride!),
      hasStartupSurge: row.hasStartupSurge,
      isMedicalRelated: row.isMedicalRelated,
      category: row.category,
      sourceApplianceId: row.id,
    );
  }
}
