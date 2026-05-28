import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:motosheet_app/main.dart';

void main() {
  testWidgets('MotoSheet opens on the parking list', (tester) async {
    await tester.pumpWidget(const MotoSheetApp());

    expect(find.textContaining('Parked'), findsWidgets);
    expect(find.text('Scan plate'), findsOneWidget);
    expect(find.text('1HH-4722'), findsOneWidget);
  });

  test('detects Cambodia-style plate formats', () {
    expect(extractPlateNumber('PP 1234'), 'PP-1234');
    expect(extractPlateNumber('SHV 6789'), 'SHV-6789');
    expect(extractPlateNumber('PP A 1234'), 'PPA-1234');
    expect(extractPlateNumber('PP-1234'), 'PP-1234');
    expect(extractPlateNumber('PP1234'), 'PP-1234');
    expect(extractPlateNumber('PHNOM PENH\n1FW-9554'), '1FW-9554');
    expect(extractPlateNumber('2K-6326'), '2K-6326');
    expect(extractPlateNumber('2KT-6326'), '2KT-6326');
    expect(extractPlateNumber('2 K 6326'), '2K-6326');
    expect(extractPlateNumber('1 HH 4722'), '1HH-4722');
  });

  test('captures English city text from the plate', () {
    final detection = extractPlateDetection('1HH-4722\nPHNOM PENH');
    expect(detection?.plate, '1HH-4722');
    expect(detection?.city, 'PHNOM PENH');
    expect(extractPlateCity('2K-6326\nPHNOM PENH'), 'PHNOM PENH');
    expect(extractPlateCity('SHV 6789\nPREAH SIHANOUK'), 'PREAH SIHANOUK');
  });

  test('cleans common OCR artifacts in digit slots', () {
    expect(extractPlateNumber('PP I2S4'), 'PP-1254');
    expect(extractPlateNumber('SHV-67B9'), 'SHV-6789');
  });

  testWidgets('editing a detected plate closes without framework errors', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () => showDialog<PlateDetection>(
              context: context,
              builder: (_) => const EditPlateDialog(initialPlate: '2K-6326', initialCity: 'PHNOM PENH'),
            ),
            child: const Text('Edit'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Use plate'));
    await tester.pumpAndSettle();

    expect(find.text('Edit plate'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('clear all records requires confirmation', (tester) async {
    await tester.pumpWidget(const MotoSheetApp());

    await tester.tap(find.byTooltip('Clear all records'));
    await tester.pumpAndSettle();
    expect(find.text('Clear all records?'), findsOneWidget);

    await tester.tap(find.text('No'));
    await tester.pumpAndSettle();
    expect(find.text('1HH-4722'), findsOneWidget);

    await tester.tap(find.byTooltip('Clear all records'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Yes, clear'));
    await tester.pumpAndSettle();

    expect(find.text('1HH-4722'), findsNothing);
    expect(find.text('All · 0'), findsOneWidget);
  });
}
