import 'dart:io';
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() async {
  await integrationDriver(responseDataCallback: (data) async {
    final screenshots = (data?['screenshots'] as List?) ?? [];
    if (screenshots.length != 24) {
      throw StateError('Expected 24 actual screenshots, got ${screenshots.length}.');
    }
    for (final raw in screenshots) {
      final record = raw as Map<String, dynamic>;
      final name = record['screenshotName'] as String;
      if (!RegExp(r'^(en|ko|ja|de|fr|es)/0[1-4]_[a-z_]+$').hasMatch(name)) {
        throw StateError('Unexpected screenshot name.');
      }
      final file = File('store-captures/$name.png');
      await file.parent.create(recursive: true);
      await file.writeAsBytes((record['bytes'] as List).cast<int>());
    }
    stdout.writeln('Saved 24 native iPhone screenshots in six languages.');
  });
}
