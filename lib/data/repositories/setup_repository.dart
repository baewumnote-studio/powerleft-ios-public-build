import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/device_input.dart';
import '../../domain/models/enums.dart';
import '../../domain/models/power_limits.dart';
import '../db/app_database.dart';

class SavedSetupBundle {
  const SavedSetupBundle(this.setup, this.items);
  final Setup setup;
  final List<SetupItem> items;
}

class SetupRepository {
  SetupRepository(this.db);
  final AppDatabase db;
  static final _uuid = Uuid();

  Stream<List<Setup>> watchAll() {
    return (db.select(
      db.setups,
    )..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])).watch();
  }

  Future<SavedSetupBundle?> getById(String id) async {
    final setup = await (db.select(
      db.setups,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (setup == null) return null;
    final items =
        await (db.select(db.setupItems)
              ..where((t) => t.setupId.equals(id))
              ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
            .get();
    return SavedSetupBundle(setup, items);
  }

  Future<String> save({
    String? id,
    required String name,
    required String mode,
    required ConnectionType connectionType,
    required List<DeviceInput> devices,
    String? batteryProfileId,
    double? capacityWh,
    double? chargePercent,
    double? desiredRuntimeHours,
    double reserveFloorPercent = 10,
    double? customEfficiency,
    double? maxContinuousOutputW,
  }) async {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty || trimmedName.length > PowerLimits.nameMaxLength) {
      throw ArgumentError.value(name, 'name', 'invalid setup name');
    }
    if (mode != 'runtime' && mode != 'batteryNeeded') {
      throw ArgumentError.value(mode, 'mode', 'unsupported setup mode');
    }
    if (devices.isEmpty) {
      throw ArgumentError.value(
        devices,
        'devices',
        'at least one device required',
      );
    }
    for (final device in devices) {
      if (device.watts <= PowerLimits.deviceWattsMinExclusive ||
          device.watts > PowerLimits.deviceWattsMax) {
        throw RangeError.value(
          device.watts,
          'device watts',
          'must be greater than ${PowerLimits.deviceWattsMinExclusive} and at most ${PowerLimits.deviceWattsMax}',
        );
      }
      if (device.usageFactor < PowerLimits.usageFactorMin ||
          device.usageFactor > PowerLimits.usageFactorMax) {
        throw RangeError.value(
          device.usageFactor,
          'device usage factor',
          'must be between ${PowerLimits.usageFactorMin} and ${PowerLimits.usageFactorMax}',
        );
      }
    }
    if (mode == 'runtime') {
      if (capacityWh == null ||
          capacityWh <= PowerLimits.capacityWhMinExclusive ||
          capacityWh > PowerLimits.capacityWhMax) {
        throw RangeError('runtime setup requires a valid capacityWh');
      }
      if (chargePercent == null ||
          chargePercent < PowerLimits.chargePercentMin ||
          chargePercent > PowerLimits.chargePercentMax) {
        throw RangeError('runtime setup requires a valid chargePercent');
      }
    }
    if (mode == 'batteryNeeded') {
      if (desiredRuntimeHours == null ||
          desiredRuntimeHours <= PowerLimits.runtimeHoursMinExclusive ||
          desiredRuntimeHours > PowerLimits.runtimeHoursMax) {
        throw RangeError(
          'batteryNeeded setup requires a valid desiredRuntimeHours',
        );
      }
    }
    if (reserveFloorPercent < PowerLimits.reserveFloorMin ||
        reserveFloorPercent > PowerLimits.reserveFloorMax) {
      throw RangeError.value(
        reserveFloorPercent,
        'reserveFloorPercent',
        'must be between ${PowerLimits.reserveFloorMin} and ${PowerLimits.reserveFloorMax}',
      );
    }
    if (customEfficiency != null &&
        (customEfficiency < PowerLimits.customEfficiencyMin ||
            customEfficiency > PowerLimits.customEfficiencyMax)) {
      throw RangeError.value(
        customEfficiency,
        'customEfficiency',
        'must be between ${PowerLimits.customEfficiencyMin} and ${PowerLimits.customEfficiencyMax}',
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
    final setupId = id ?? _uuid.v4();
    final existing = await (db.select(
      db.setups,
    )..where((t) => t.id.equals(setupId))).getSingleOrNull();

    await db.transaction(() async {
      await db
          .into(db.setups)
          .insertOnConflictUpdate(
            SetupsCompanion(
              id: Value(setupId),
              name: Value(trimmedName),
              mode: Value(mode),
              batteryProfileId: Value(batteryProfileId),
              capacityWhSnapshot: Value(capacityWh),
              chargePercentSnapshot: Value(chargePercent),
              connectionType: Value(connectionType.wireValue),
              desiredRuntimeHours: Value(desiredRuntimeHours),
              reserveFloorPercent: Value(reserveFloorPercent),
              customEfficiency: Value(customEfficiency),
              maxContinuousOutputW: Value(maxContinuousOutputW),
              createdAt: Value(existing?.createdAt ?? now),
              updatedAt: Value(now),
            ),
          );
      await (db.delete(
        db.setupItems,
      )..where((t) => t.setupId.equals(setupId))).go();
      for (var index = 0; index < devices.length; index++) {
        final d = devices[index];
        await db
            .into(db.setupItems)
            .insert(
              SetupItemsCompanion.insert(
                id: _uuid.v4(),
                setupId: setupId,
                nameSnapshot: d.name,
                wattsSnapshot: d.watts,
                usageFactorSnapshot: d.usageFactor,
                usagePatternSnapshot: Value(d.usagePattern.wireValue),
                connectionOverride: Value(d.connectionOverride?.wireValue),
                hasStartupSurge: Value(d.hasStartupSurge),
                isMedicalRelated: Value(d.isMedicalRelated),
                categorySnapshot: Value(d.category),
                sortOrder: index,
                sourceApplianceId: Value(d.sourceApplianceId),
              ),
            );
      }
    });
    return setupId;
  }

  Future<void> rename(String id, String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty || trimmed.length > PowerLimits.nameMaxLength) {
      throw ArgumentError.value(name, 'name', 'invalid setup name');
    }
    await (db.update(db.setups)..where((t) => t.id.equals(id))).write(
      SetupsCompanion(
        name: Value(trimmed),
        updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  Future<void> delete(String id) =>
      (db.delete(db.setups)..where((t) => t.id.equals(id))).go();

  List<DeviceInput> devicesFromItems(List<SetupItem> items) {
    return items
        .map((row) {
          final storedFactor = row.usageFactorSnapshot;
          final pattern = UsagePatternX.fromWire(row.usagePatternSnapshot);
          return DeviceInput(
            name: row.nameSnapshot,
            watts: row.wattsSnapshot,
            usagePattern: pattern,
            customUsageFactor: storedFactor,
            connectionOverride: row.connectionOverride == null
                ? null
                : ConnectionTypeX.fromWire(row.connectionOverride!),
            hasStartupSurge: row.hasStartupSurge,
            isMedicalRelated: row.isMedicalRelated,
            category: row.categorySnapshot,
            sourceApplianceId: row.sourceApplianceId,
          );
        })
        .toList(growable: false);
  }
}
