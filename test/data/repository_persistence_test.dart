import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:powerleft/data/db/app_database.dart';
import 'package:powerleft/data/repositories/battery_profile_repository.dart';
import 'package:powerleft/data/repositories/custom_appliance_repository.dart';
import 'package:powerleft/data/repositories/setup_repository.dart';
import 'package:powerleft/domain/models/device_input.dart';
import 'package:powerleft/domain/models/enums.dart';

void main() {
  late AppDatabase db;
  late SetupRepository setups;
  late CustomApplianceRepository appliances;
  late BatteryProfileRepository batteries;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    setups = SetupRepository(db);
    appliances = CustomApplianceRepository(db);
    batteries = BatteryProfileRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test(
    'setup save -> load preserves device snapshot and assumptions',
    () async {
      final device = DeviceInput(
        name: 'Fridge',
        watts: 120,
        usagePattern: UsagePattern.cycles,
        customUsageFactor: 0.42,
        connectionOverride: ConnectionType.ac,
        hasStartupSurge: true,
        category: 'home_backup',
      );

      final id = await setups.save(
        name: 'Blackout',
        mode: 'runtime',
        connectionType: ConnectionType.ac,
        devices: [device],
        batteryProfileId: 'battery-profile-123',
        capacityWh: 1024,
        chargePercent: 82,
        reserveFloorPercent: 10,
        customEfficiency: 0.88,
        maxContinuousOutputW: 1800,
      );

      final loaded = await setups.getById(id);
      expect(loaded, isNotNull);
      expect(loaded!.setup.name, 'Blackout');
      expect(loaded.setup.batteryProfileId, 'battery-profile-123');
      expect(loaded.setup.capacityWhSnapshot, 1024);
      expect(loaded.setup.chargePercentSnapshot, 82);
      expect(loaded.items, hasLength(1));

      final restored = setups.devicesFromItems(loaded.items).single;
      expect(restored.name, 'Fridge');
      expect(restored.watts, 120);
      expect(restored.usageFactor, closeTo(0.42, 0.0001));
      expect(restored.hasStartupSurge, isTrue);
    },
  );

  test('updating a setup replaces old item snapshots', () async {
    final id = await setups.save(
      name: 'Camping',
      mode: 'runtime',
      connectionType: ConnectionType.dc12v,
      devices: [
        const DeviceInput(
          name: 'Old',
          watts: 40,
          usagePattern: UsagePattern.alwaysOn,
        ),
      ],
      capacityWh: 500,
      chargePercent: 100,
    );

    await setups.save(
      id: id,
      name: 'Camping Updated',
      mode: 'runtime',
      connectionType: ConnectionType.dc12v,
      devices: [
        const DeviceInput(
          name: 'New',
          watts: 55,
          usagePattern: UsagePattern.alwaysOn,
        ),
      ],
      capacityWh: 600,
      chargePercent: 90,
    );

    final loaded = await setups.getById(id);
    expect(loaded!.setup.name, 'Camping Updated');
    expect(loaded.items, hasLength(1));
    expect(loaded.items.single.nameSnapshot, 'New');
  });

  test('deleting setup cascades setup items', () async {
    final id = await setups.save(
      name: 'Delete me',
      mode: 'runtime',
      connectionType: ConnectionType.ac,
      devices: [
        const DeviceInput(
          name: 'Lamp',
          watts: 10,
          usagePattern: UsagePattern.alwaysOn,
        ),
      ],
      capacityWh: 300,
      chargePercent: 100,
    );

    await setups.delete(id);

    expect(await setups.getById(id), isNull);
    final orphans = await db.select(db.setupItems).get();
    expect(orphans, isEmpty);
  });

  test('custom appliance upsert -> reload preserves fields', () async {
    const device = DeviceInput(
      name: 'My Heater',
      watts: 750,
      usagePattern: UsagePattern.occasional,
      customUsageFactor: 0.3,
      connectionOverride: ConnectionType.ac,
      hasStartupSurge: false,
      category: 'custom',
    );

    await appliances.upsert(device: device);
    final rows = await db.select(db.customAppliances).get();
    expect(rows, hasLength(1));

    final restored = appliances.toDeviceInput(rows.single);
    expect(restored.name, 'My Heater');
    expect(restored.watts, 750);
    expect(restored.usageFactor, closeTo(0.3, 0.0001));
    expect(restored.connectionOverride, ConnectionType.ac);
  });

  test('battery profile persists and can be deleted', () async {
    await batteries.upsert(
      name: 'Station A',
      capacityWh: 1024,
      connection: ConnectionType.ac,
      currentChargePercent: 85,
      maxContinuousOutputW: 1800,
    );

    final rows = await db.select(db.batteryProfiles).get();
    expect(rows, hasLength(1));
    expect(rows.single.capacityWh, 1024);
    expect(rows.single.currentChargePercent, 85);

    await batteries.delete(rows.single.id);
    expect(await db.select(db.batteryProfiles).get(), isEmpty);
  });

  test('clearUserData deletes all persisted domain records', () async {
    await batteries.upsert(
      name: 'Battery',
      capacityWh: 500,
      connection: ConnectionType.ac,
    );
    await appliances.upsert(
      device: const DeviceInput(
        name: 'Lamp',
        watts: 10,
        usagePattern: UsagePattern.alwaysOn,
      ),
    );
    await setups.save(
      name: 'Setup',
      mode: 'runtime',
      connectionType: ConnectionType.ac,
      devices: const [
        DeviceInput(
          name: 'Router',
          watts: 10,
          usagePattern: UsagePattern.alwaysOn,
        ),
      ],
      capacityWh: 500,
      chargePercent: 100,
    );

    await db.clearUserData();

    expect(await db.select(db.batteryProfiles).get(), isEmpty);
    expect(await db.select(db.customAppliances).get(), isEmpty);
    expect(await db.select(db.setups).get(), isEmpty);
    expect(await db.select(db.setupItems).get(), isEmpty);
  });

  test('rename updates setup name', () async {
    final id = await setups.save(
      name: 'Old name',
      mode: 'runtime',
      connectionType: ConnectionType.ac,
      devices: const [
        DeviceInput(
          name: 'Router',
          watts: 10,
          usagePattern: UsagePattern.alwaysOn,
        ),
      ],
      capacityWh: 500,
      chargePercent: 100,
    );

    await setups.rename(id, 'New name');
    final loaded = await setups.getById(id);
    expect(loaded!.setup.name, 'New name');
  });

  test(
    'deleting battery profile detaches setup link but keeps snapshot',
    () async {
      await batteries.upsert(
        name: 'Linked Battery',
        capacityWh: 1024,
        connection: ConnectionType.ac,
      );
      final battery = (await db.select(db.batteryProfiles).get()).single;

      final setupId = await setups.save(
        name: 'Linked Setup',
        mode: 'runtime',
        connectionType: ConnectionType.ac,
        batteryProfileId: battery.id,
        devices: const [
          DeviceInput(
            name: 'Router',
            watts: 10,
            usagePattern: UsagePattern.alwaysOn,
          ),
        ],
        capacityWh: 1024,
        chargePercent: 90,
      );

      await batteries.delete(battery.id);

      final loaded = await setups.getById(setupId);
      expect(loaded, isNotNull);
      expect(loaded!.setup.batteryProfileId, isNull);
      expect(loaded.setup.capacityWhSnapshot, 1024);
      expect(loaded.setup.chargePercentSnapshot, 90);
    },
  );

  test('repositories reject invalid persisted values', () async {
    await expectLater(
      batteries.upsert(
        name: '',
        capacityWh: 1000,
        connection: ConnectionType.ac,
      ),
      throwsArgumentError,
    );

    await expectLater(
      appliances.upsert(
        device: const DeviceInput(
          name: 'Too Much',
          watts: 10001,
          usagePattern: UsagePattern.alwaysOn,
        ),
      ),
      throwsRangeError,
    );

    await expectLater(
      setups.save(
        name: 'Invalid',
        mode: 'runtime',
        connectionType: ConnectionType.ac,
        devices: const [
          DeviceInput(
            name: 'Lamp',
            watts: 10,
            usagePattern: UsagePattern.alwaysOn,
          ),
        ],
        capacityWh: 1000,
        chargePercent: 101,
      ),
      throwsRangeError,
    );
  });

  test(
    'saved setup snapshots are independent from later source edits',
    () async {
      await batteries.upsert(
        name: 'Original Battery',
        capacityWh: 1000,
        connection: ConnectionType.ac,
        currentChargePercent: 80,
      );
      final battery = (await db.select(db.batteryProfiles).get()).single;

      await appliances.upsert(
        device: const DeviceInput(
          name: 'Original Device',
          watts: 100,
          usagePattern: UsagePattern.alwaysOn,
        ),
      );
      final appliance = (await db.select(db.customAppliances).get()).single;

      final setupId = await setups.save(
        name: 'Snapshot Setup',
        mode: 'runtime',
        connectionType: ConnectionType.ac,
        batteryProfileId: battery.id,
        devices: [appliances.toDeviceInput(appliance)],
        capacityWh: 1000,
        chargePercent: 80,
      );

      await batteries.upsert(
        id: battery.id,
        name: 'Changed Battery',
        capacityWh: 2000,
        connection: ConnectionType.ac,
        currentChargePercent: 55,
      );
      await appliances.upsert(
        id: appliance.id,
        device: const DeviceInput(
          name: 'Changed Device',
          watts: 250,
          usagePattern: UsagePattern.alwaysOn,
        ),
      );

      final loaded = await setups.getById(setupId);
      expect(loaded, isNotNull);
      expect(loaded!.setup.capacityWhSnapshot, 1000);
      expect(loaded.setup.chargePercentSnapshot, 80);
      expect(loaded.items.single.nameSnapshot, 'Original Device');
      expect(loaded.items.single.wattsSnapshot, 100);
    },
  );

  test(
    'deleting a custom appliance does not delete saved setup snapshot',
    () async {
      await appliances.upsert(
        device: const DeviceInput(
          name: 'Temporary Device',
          watts: 75,
          usagePattern: UsagePattern.usuallyOn,
        ),
      );
      final appliance = (await db.select(db.customAppliances).get()).single;

      final setupId = await setups.save(
        name: 'Keep Snapshot',
        mode: 'runtime',
        connectionType: ConnectionType.ac,
        devices: [appliances.toDeviceInput(appliance)],
        capacityWh: 800,
        chargePercent: 100,
      );

      await appliances.delete(appliance.id);

      expect(await db.select(db.customAppliances).get(), isEmpty);
      final loaded = await setups.getById(setupId);
      expect(loaded, isNotNull);
      expect(loaded!.items, hasLength(1));
      expect(loaded.items.single.nameSnapshot, 'Temporary Device');
      expect(loaded.items.single.wattsSnapshot, 75);
    },
  );

  test('built-in appliance source id survives setup round-trip', () async {
    const device = DeviceInput(
      name: 'Refrigerator',
      watts: 120,
      usagePattern: UsagePattern.cycles,
      sourceApplianceId: 'refrigerator',
      category: 'home_backup',
      hasStartupSurge: true,
    );

    final setupId = await setups.save(
      name: 'Built-in Snapshot',
      mode: 'runtime',
      connectionType: ConnectionType.ac,
      devices: const [device],
      capacityWh: 1000,
      chargePercent: 100,
    );

    final loaded = await setups.getById(setupId);
    final restored = setups.devicesFromItems(loaded!.items).single;
    expect(restored.sourceApplianceId, 'refrigerator');
    expect(restored.category, 'home_backup');
    expect(restored.hasStartupSurge, isTrue);
  });
}
