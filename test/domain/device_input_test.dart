import 'package:flutter_test/flutter_test.dart';
import 'package:powerleft/domain/models/device_input.dart';
import 'package:powerleft/domain/models/enums.dart';

void main() {
  test('copyWith edits calculator values without losing preset identity', () {
    const original = DeviceInput(
      name: 'Refrigerator',
      watts: 120,
      usagePattern: UsagePattern.cycles,
      sourceApplianceId: 'refrigerator',
      category: 'home_backup',
      hasStartupSurge: true,
    );

    final edited = original.copyWith(
      watts: 95,
      usagePattern: UsagePattern.custom,
      customUsageFactor: 0.35,
    );

    expect(edited.sourceApplianceId, 'refrigerator');
    expect(edited.category, 'home_backup');
    expect(edited.hasStartupSurge, isTrue);
    expect(edited.watts, 95);
    expect(edited.usageFactor, closeTo(0.35, 0.0001));
  });

  test('copyWith can clear a connection override', () {
    const original = DeviceInput(
      name: 'Laptop',
      watts: 65,
      usagePattern: UsagePattern.usuallyOn,
      connectionOverride: ConnectionType.usbC,
    );

    final edited = original.copyWith(clearConnectionOverride: true);
    expect(edited.connectionOverride, isNull);
  });

  test('copyWith can clear a custom usage factor', () {
    const original = DeviceInput(
      name: 'Cycling load',
      watts: 100,
      usagePattern: UsagePattern.custom,
      customUsageFactor: 0.35,
    );

    final edited = original.copyWith(
      usagePattern: UsagePattern.alwaysOn,
      clearCustomUsageFactor: true,
    );

    expect(edited.customUsageFactor, isNull);
    expect(edited.usageFactor, 1.0);
  });
}
