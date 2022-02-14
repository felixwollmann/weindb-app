import 'package:flutter_test/flutter_test.dart';
import 'package:weindb/cubits/SettingsState.dart';

void main() {
  group('SettingsState', () {
    test("==-Operator", () {
      var settingsState = SettingsState({'hi': 'there', 'a-number': 1});
      var settingsState2 = SettingsState({'hi': 'there', 'a-number': 1});

      expect(settingsState.settings, {'hi': 'there', 'a-number': 1});

      expect(settingsState, equals(settingsState2));
    });

    test('copyWith-Method', () {
      var settingsState = SettingsState({'hi': 'there', 'a-number': 1});
      var settingsState2 = settingsState.copyWith(
        settings: {'hi': 'there', 'a-number': 2},
      );

      expect(settingsState2.settings, {'hi': 'there', 'a-number': 2});
    });
  });
}
