// This is a basic Flutter widget test.

// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weindb/main.dart';
import 'package:weindb/models/models.dart';
import 'package:weindb/settings_generation/settings_generation.dart';
import 'package:weindb/widgets/list_items/wein_list_item.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final wein = WeinModel(
      id: 1,
      name: 'Wein',
      sorte: SorteModel(id: 1, name: 'Sorte', farbe: WeinFarbe.red),
      anzahl: 1,
      getrunken: 1,
      jahr: 2020,
      weinbauer: WeinbauerModel(
          id: 1,
          name: 'Weinbauer',
          region: RegionModel(id: 1, name: 'Region', land: 'AT'),
          beschreibung: 'Beschreibung'),
      gekauft: DateTime.utc(2020),
      beschreibung: 'Beschreibung',
      inhalt: 0.75,
      fach: 10,
      preis: 10.0,
    );
    // Build our app and trigger a frame.
    await tester.pumpWidget(WeinListItem(wein));

    // TODO: diesen Test hier schreiben

    // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
