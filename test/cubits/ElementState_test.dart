import 'package:test/test.dart';
import 'package:weindb/cubits/ElementState.dart';
import 'package:weindb/models/models.dart';
// import 'package:weindb/classes/classes.dart';
// import 'package:weindb/models/models.dart';
// import 'package:weindb/cubits/DatabaseProvider.dart';
// import 'pac'

void main() {
  group('==-Operator', () {
    test('with default values', () {
      var state = ElementState();
      var state2 = ElementState();
      expect(state == state2, true);
    });
    test('with custom values', () {
      var state = ElementState(
        isReloading: true,
        isInitializing: false,
        isError: false,
        data: <SorteModel>[
          SorteModel(id: 1234, name: 'Test-Sorte', farbe: WeinFarbe.white),
        ],
      );
      var state2 = ElementState(
        isReloading: true,
        isInitializing: false,
        isError: false,
        data: <SorteModel>[
          SorteModel(
              id: 1234,
              name: 'Test-Sorte',
              farbe: WeinFarbenHelper.fromString('Weiß')!),
        ],
      );
      expect(state == state2, true);
    });
    test('with copyWith-Method', () {
      var state = ElementState(
        isReloading: false,
        isInitializing: true,
        isError: true,
        data: <SorteModel>[
          SorteModel(id: 4321, name: 'Test-Sorte-2', farbe: WeinFarbe.red),
        ],
      );

      var defaultState = ElementState<SorteModel>();
      var state2 = defaultState.copyWith(
        isInitializing: true,
        isError: true,
        data: <SorteModel>[
          SorteModel(
              id: 4321,
              name: 'Test-Sorte-2',
              farbe: WeinFarbenHelper.fromString('Rot')!),
        ],
      );
      expect(state == state2, true);
    });
  });

  // the copyWith method was already tested in the ==-operator test
}
