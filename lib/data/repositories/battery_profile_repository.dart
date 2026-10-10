import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/enums.dart';
import '../../domain/models/power_limits.dart';
import '../db/app_database.dart';

class BatteryProfileRepository {
  BatteryProfileRepository(this.db);
  final AppDatabase db;
  static final _uuid = Uuid();

  Stream<List<BatteryProfile>> watchAll() {
    return (db.select(
      db.batteryProfiles,
    )..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();
  }

  Future<void> upsert({
    String? id,
    required String name,
    required double capacityWh,
    required ConnectionType connection,
    double currentChargePercent = 100,
    double? maxContinuousOutputW,
    String? notes,
  }) async {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty || trimmedName.length > PowerLimits.nameMaxLength) {
      throw ArgumentError.value(name, 'name', 'invalid battery name');
    }
    if (capacityWh <= PowerLimits.capacityWhMinExclusive ||
        capacityWh > PowerLimits.capacityWhMax) {
      throw RangeError.value(
        capacityWh,
        'capacityWh',
        'must be greater than ${PowerLimits.capacityWhMinExclusive} and at most ${PowerLimits.capacityWhMax}',
      );
    }
    if (currentChargePercent < PowerLimits.chargePercentMin ||
        currentChargePercent > PowerLimits.chargePercentMax) {
      throw RangeError.value(
        currentChargePercent,
        'currentChargePercent',
        'must be between ${PowerLimits.chargePercentMin} and ${PowerLimits.chargePercentMax}',
      );
    }
    if (maxContinuousOutputW != null && maxContinuousOutputW <= 0) {
      throw RangeError.value(
        maxContinuousOutputW,
        'maxContinuousOutputW',
        'must be greater than zero',
      );
    }

    final now = DateTime.now().millisecondsSinceEpoch;
    final rowId = id ?? _uuid.v4();
    final existing = id == null
        ? null
        : await (db.select(
            db.batteryProfiles,
          )..where((t) => t.id.equals(id))).getSingleOrNull();

    await db
        .into(db.batteryProfiles)
        .insertOnConflictUpdate(
          BatteryProfilesCompanion(
            id: Value(rowId),
            name: Value(trimmedName),
            capacityWh: Value(capacityWh),
            defaultConnectionType: Value(connection.wireValue),
            currentChargePercent: Value(currentChargePercent),
            maxContinuousOutputW: Value(maxContinuousOutputW),
            notes: Value(notes),
            createdAt: Value(existing?.createdAt ?? now),
            updatedAt: Value(now),
          ),
        );
  }

  Future<void> delete(String id) async {
    await db.transaction(() async {
      await (db.update(db.setups)..where((t) => t.batteryProfileId.equals(id)))
          .write(const SetupsCompanion(batteryProfileId: Value<String?>(null)));
      await (db.delete(db.batteryProfiles)..where((t) => t.id.equals(id))).go();
    });
  }
}
