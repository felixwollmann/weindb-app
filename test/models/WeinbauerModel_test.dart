import 'package:test/test.dart';
import 'package:weindb/models/models.dart';

void main() {
  group('WeinbauerModel', () {
    test(
      'Erstellung über Konstruktor',
      () {
        final weinbauer = WeinbauerModel(
          id: 1,
          name: 'Weinbauer',
        );
        expect(weinbauer.id, 1);
        expect(weinbauer.name, 'Weinbauer');
        expect(weinbauer.region, null);
        expect(weinbauer.beschreibung, null);

        final weinbauer2 = WeinbauerModel(
          id: 1,
          name: 'Weinbauer',
          region: RegionModel(id: 1, name: 'Region', land: 'AT'),
          beschreibung: 'Beschreibung',
        );
        expect(weinbauer2.id, 1);
        expect(weinbauer2.name, 'Weinbauer');
        expect(
          weinbauer2.region,
          RegionModel(id: 1, name: 'Region', land: 'AT'),
        );
        expect(weinbauer2.beschreibung, 'Beschreibung');
      },
    );

    test('==-Operator', () {
      final region = RegionModel(id: 1, name: 'Region', land: 'AT');
      final weinbauer = WeinbauerModel(
        id: 1,
        name: 'Weinbauer',
        region: region,
        beschreibung: 'Beschreibung',
      );

      final weinbauer1 = WeinbauerModel(
        id: 1,
        name: 'Weinbauer',
        region: region,
        beschreibung: 'Beschreibung',
      );

      expect(weinbauer, weinbauer1);

      expect(weinbauer.hashCode, weinbauer1.hashCode);
    });

    test('fromJson', () {
      final json = {
        'id': 1,
        'name': 'Weinbauer',
        'regionen': {
          'id': 1,
          'name': 'Region',
          'land': 'AT',
        },
        'beschreibung': 'Beschreibung',
      };

      final weinbauerFromJson = WeinbauerModel.fromJson(json);

      final weinbauer = WeinbauerModel(
        id: 1,
        name: 'Weinbauer',
        region: RegionModel(id: 1, name: 'Region', land: 'AT'),
        beschreibung: 'Beschreibung'
      );

      expect(weinbauerFromJson, weinbauer);
    });

    test('toJson', () {
      final json = {
        'id': 1,
        'name': 'Weinbauer',
        'regionen': {
          'id': 1,
          'name': 'Region',
          'land': 'AT',
          'beschreibung': null
        },
        'beschreibung': 'Beschreibung',
      };

      final weinbauer = WeinbauerModel(
        id: 1,
        name: 'Weinbauer',
        region: RegionModel(id: 1, name: 'Region', land: 'AT'),
        beschreibung: 'Beschreibung'
      );

      expect(weinbauer.toJson(), json);
    });
  });
}
