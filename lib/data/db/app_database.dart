import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class BatteryProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  RealColumn get capacityWh => real()();
  TextColumn get defaultConnectionType =>
      text().withDefault(const Constant('AC'))();
  RealColumn get currentChargePercent =>
      real().withDefault(const Constant(100.0))();
  RealColumn get maxContinuousOutputW => real().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class CustomAppliances extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  RealColumn get watts => real()();
  TextColumn get usagePattern =>
      text().withDefault(const Constant('alwaysOn'))();
  RealColumn get customUsageFactor => real().nullable()();
  TextColumn get category => text().withDefault(const Constant('other'))();
  TextColumn get connectionOverride => text().nullable()();
  BoolColumn get hasStartupSurge =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isMedicalRelated =>
      boolean().withDefault(const Constant(false))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Setups extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  TextColumn get mode => text()();
  TextColumn get batteryProfileId => text().nullable()();
  RealColumn get capacityWhSnapshot => real().nullable()();
  RealColumn get chargePercentSnapshot => real().nullable()();
  TextColumn get connectionType => text().withDefault(const Constant('AC'))();
  RealColumn get desiredRuntimeHours => real().nullable()();
  RealColumn get reserveFloorPercent =>
      real().withDefault(const Constant(10.0))();
  RealColumn get customEfficiency => real().nullable()();
  RealColumn get maxContinuousOutputW => real().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class SetupItems extends Table {
  TextColumn get id => text()();
  TextColumn get setupId =>
      text().references(Setups, #id, onDelete: KeyAction.cascade)();
  TextColumn get sourceApplianceId => text().nullable()();
  TextColumn get nameSnapshot => text()();
  RealColumn get wattsSnapshot => real()();
  RealColumn get usageFactorSnapshot => real()();
  TextColumn get usagePatternSnapshot =>
      text().withDefault(const Constant('alwaysOn'))();
  TextColumn get connectionOverride => text().nullable()();
  BoolColumn get hasStartupSurge =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isMedicalRelated =>
      boolean().withDefault(const Constant(false))();
  TextColumn get categorySnapshot =>
      text().withDefault(const Constant('other'))();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [BatteryProfiles, CustomAppliances, Setups, SetupItems])
final class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'powerleft'));

  @override
  int get schemaVersion => 1;

  Future<void> clearUserData() async {
    await transaction(() async {
      await delete(setupItems).go();
      await delete(setups).go();
      await delete(customAppliances).go();
      await delete(batteryProfiles).go();
    });
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      // Schema v1 initial release. Add explicit migrations here for future versions.
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
