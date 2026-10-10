enum ConnectionType { ac, dc12v, usbC }

extension ConnectionTypeX on ConnectionType {
  String get wireValue => switch (this) {
    ConnectionType.ac => 'AC',
    ConnectionType.dc12v => 'DC12V',
    ConnectionType.usbC => 'USB_C',
  };

  String get shortLabel => switch (this) {
    ConnectionType.ac => 'AC',
    ConnectionType.dc12v => '12V DC',
    ConnectionType.usbC => 'USB-C',
  };

  static ConnectionType fromWire(String value) => switch (value) {
    'DC12V' => ConnectionType.dc12v,
    'USB_C' => ConnectionType.usbC,
    _ => ConnectionType.ac,
  };
}

enum UsagePattern { alwaysOn, usuallyOn, cycles, occasional, custom }

extension UsagePatternX on UsagePattern {
  double defaultFactor(double? custom) => switch (this) {
    UsagePattern.alwaysOn => 1.0,
    UsagePattern.usuallyOn => 0.75,
    UsagePattern.cycles => 0.50,
    UsagePattern.occasional => 0.25,
    UsagePattern.custom => (custom ?? 1.0).clamp(0.05, 1.0).toDouble(),
  };

  String get wireValue => name;

  static UsagePattern fromWire(String value) => UsagePattern.values.firstWhere(
    (e) => e.name == value,
    orElse: () => UsagePattern.alwaysOn,
  );
}

enum CalculationProfile { conservative, typical, best }
