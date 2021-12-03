import 'package:test/test.dart';
import 'package:weindb/models/models.dart';

void main() {
  group('Wein', () {
    test('Erstellung über Konstruktor', () {
      final jetzt = DateTime.now();
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
        gekauft: jetzt,
        beschreibung: 'Beschreibung',
        inhalt: 0.75,
        fach: 10,
        preis: 10.0,
      );

      expect(wein.id, 1);
      expect(wein.name, 'Wein');
      expect(wein.sorte.id, 1);
      expect(wein.sorte.name, 'Sorte');
      expect(wein.sorte.farbe, WeinFarbe.red);
      expect(wein.anzahl, 1);
      expect(wein.getrunken, 1);
      expect(wein.jahr, 2020);
      expect(wein.weinbauer!.id, 1);
      expect(wein.weinbauer!.name, 'Weinbauer');
      expect(wein.weinbauer!.region!.id, 1);
      expect(wein.weinbauer!.region!.name, 'Region');
      expect(wein.weinbauer!.region!.land, 'AT');
      expect(wein.weinbauer!.beschreibung, 'Beschreibung');
      expect(wein.gekauft, jetzt);
      expect(wein.beschreibung, 'Beschreibung');
      expect(wein.inhalt, 0.75);
      expect(wein.fach, 10);
      expect(wein.preis, 10.0);
    });

    test('==-Operator', () {
      final jetzt = DateTime.now();
      final auchJetzt = DateTime.now();

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
        gekauft: jetzt,
        beschreibung: 'Beschreibung',
        inhalt: 0.75,
        fach: 10,
        preis: 10.0,
      );

      final wein1 = WeinModel(
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
        gekauft: auchJetzt,
        beschreibung: 'Beschreibung',
        inhalt: 0.75,
        fach: 10,
        preis: 10.0,
      );

      expect(wein, wein1);
    });

    test('fromJson', () {
      final jetzt = DateTime.now();
// 2020-07-03T22:00:00.000Z
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
        gekauft: jetzt,
        beschreibung: 'Beschreibung',
        inhalt: 0.75,
        fach: 10,
        preis: 10.0,
      );

      final json = {
        'id': 1,
        'name': 'Wein',
        'sorten': {'id': 1, 'name': 'Sorte', 'farbe': 0},
        'anzahl': 1,
        'getrunken': 1,
        'jahr': 2020,
        'weinbauern': {
          'id': 1,
          'name': 'Weinbauer',
          'regionen': {'id': 1, 'name': 'Region', 'land': 'AT'},
          'beschreibung': 'Beschreibung'
        },
        'gekauft': jetzt.toIso8601String(),
        'beschreibung': 'Beschreibung',
        'inhalt': 0.75,
        'fach': 10,
        'preis': 10.0,
      };

      final weinFromJson = WeinModel.fromJson(json);

      expect(wein, weinFromJson);
    });

    test('toJson', () {
      final jetzt = DateTime.now();

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
        gekauft: jetzt,
        beschreibung: 'Beschreibung',
        inhalt: 0.75,
        fach: 10,
        preis: 10.0,
      );

      final json = {
        'id': 1,
        'name': 'Wein',
        'sorten': {'id': 1, 'name': 'Sorte', 'farbe': 0},
        'anzahl': 1,
        'getrunken': 1,
        'jahr': 2020,
        'weinbauern': {
          'id': 1,
          'name': 'Weinbauer',
          'regionen': {'id': 1, 'name': 'Region', 'land': 'AT', 'beschreibung': null},
          'beschreibung': 'Beschreibung'
        },
        'gekauft': jetzt.toIso8601String(),
        'beschreibung': 'Beschreibung',
        'inhalt': 0.75,
        'fach': 10,
        'preis': 10.0,
      };

      expect(wein.toJson(), json);
    });
  });
}
