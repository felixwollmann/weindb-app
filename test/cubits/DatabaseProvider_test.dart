import 'package:test/test.dart';
// import 'package:weindb/classes/classes.dart';
import 'package:weindb/models/models.dart';
import 'package:weindb/cubits/DatabaseProvider.dart';
// import 'pac'

void main() {
  final db = DatabaseProvider(baseURL: "http://192.168.100.10/test/");
  group('Sorte-Unit', () {
    test('getSorten', () async {
      final sorten = await db.getSorten();
      expect(sorten is List<SorteModel>, true);
    });
  });

  group('Region-Unit', () {
    test('getRegionen', () async {
      final regionen = await db.getRegionen();
      expect(regionen is List<RegionModel>, true);
    });
  });

  group('Weinbauer-Unit', () {
    test('getWeinbauern', () async {
      final weinbauern = await db.getWeinbauern();
      expect(weinbauern is List<WeinbauerModel>, true);
    });
  });

  group('Wein-Unit', () {
    test('getWein', () async {
      final weine = await db.getWeine();
      expect(weine is List<WeinModel>, true);
    });
  });

  group('Integration', () {
    test('Add a Wein and make sure it is saved in the Database', () async {
      final sorte = (await db.getSorten())[1];
      final weinbauer = (await db.getWeinbauern())[1];
      final jetzt = DateTime.now();
      final wein = WeinModel(
        id: 0, // it is not saved yet
        name: 'TEST-WEIN',
        sorte: sorte,
        anzahl: 10,
        getrunken: 20,
        jahr: 2020,
        weinbauer: weinbauer,
        gekauft: jetzt,
        beschreibung: null, // to make sure it is saved correctly
        inhalt: 0.75,
        fach: 10,
        preis: 10.0,
      );
      final int weinAddedId = await db.postWein(wein);
      expect(weinAddedId > 0, true, reason: 'ID muss größer als 0 sein');

      final weine = await db.getWeine();
      expect(weine.any((wein) => wein.id == weinAddedId), true, reason: 'Wein wurde nicht zur Datenbank hinzugefügt');
      // expect(weine.any((element) => element == weinAdded), true, reason: 'Wein was not added to the Database');


      
      // await db.saveWein(wein);

      // final wei1n = WeinModel(
      //   id: 1,
      //   name: 'Wein',
      //   sorte: SorteModel(id: 1, name: 'Sorte', farbe: WeinFarbe.red),
      //   anzahl: 1,
      //   getrunken: 1,
      //   jahr: 2020,
      //   weinbauer: WeinbauerModel(
      //       id: 1,
      //       name: 'Weinbauer',
      //       region: RegionModel(id: 1, name: 'Region', land: 'AT'),
      //       beschreibung: 'Beschreibung'),
      //   gekauft: jetzt,
      //   beschreibung: 'Beschreibung',
      //   inhalt: 0.75,
      //   fach: 10,
      //   preis: 10.0,
      // );
    });
  });
}
