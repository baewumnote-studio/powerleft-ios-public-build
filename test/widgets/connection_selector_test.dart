import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:powerleft/core/widgets/connection_selector.dart';
import 'package:powerleft/domain/models/enums.dart';

void main() {
  testWidgets('normal text uses segmented connection selector', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 390,
            child: ConnectionSelector(
              value: ConnectionType.ac,
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    expect(find.byType(SegmentedButton<ConnectionType>), findsOneWidget);
    expect(find.byType(DropdownButtonFormField<ConnectionType>), findsNothing);
  });

  testWidgets('large text uses dropdown to avoid segmented clipping', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.5)),
          child: child!,
        ),
        home: Scaffold(
          body: SizedBox(
            width: 390,
            child: ConnectionSelector(
              value: ConnectionType.ac,
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    expect(
      find.byType(DropdownButtonFormField<ConnectionType>),
      findsOneWidget,
    );
    expect(find.byType(SegmentedButton<ConnectionType>), findsNothing);
  });

  testWidgets('narrow width uses dropdown even at normal text size', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(340, 700);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ConnectionSelector(
            value: ConnectionType.dc12v,
            onChanged: (_) {},
          ),
        ),
      ),
    );

    expect(
      find.byType(DropdownButtonFormField<ConnectionType>),
      findsOneWidget,
    );
  });
}
