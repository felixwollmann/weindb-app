import 'dart:math';

import 'package:test/test.dart';
import 'package:weindb/cubits/ephemeral_database_provider.dart';
// import 'package:weindb/classes/classes.dart';
import 'package:weindb/models/models.dart';
import 'package:weindb/cubits/DatabaseProvider.dart';
// import 'pac'

void main() {
  final db = EphemeralDatabaseProvider();
  db.populate(100, 1); // 100 entries, seed: 1
  group('Sorte-Unit', () { // these tests below basically check if any runtime exceptions occur, teh
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
    test(
        'Add a Wein and make sure it is saved in the Database, then delete it again',
        () async {
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

      var weine = await db.getWeine();
      expect(weine.any((wein) => wein.id == weinAddedId), true,
          reason: 'Wein wurde nicht zur Datenbank hinzugefügt');

      final newWein = weine.firstWhere((element) => element.id == weinAddedId);

      final newSorte = (await db.getSorten())[2];
      final editedWein = newWein.copyWith(
        name: 'TEST-WEIN-EDIT',
        sorte: newSorte,
        anzahl: 11,
        preis: 11.0,
        weinbauer: weinbauer,
        gekauft: jetzt,
        beschreibung: "Hallo",
      );

      await db.patchWein(editedWein);
      weine = await db.getWeine();

      expect(weine.any((element) => element.id == weinAddedId), true,
          reason: 'Wein wurde nicht zur Datenbank hinzugefügt');
      final savedEditedWein =
          weine.firstWhere((element) => element.id == weinAddedId);
      expect(savedEditedWein.name, 'TEST-WEIN-EDIT');
      expect(savedEditedWein.sorte, newSorte);
      expect(savedEditedWein.anzahl, 11);
      expect(savedEditedWein.preis, 11.0);
      expect(savedEditedWein.weinbauer, weinbauer);
      expect(savedEditedWein.gekauft!.difference(jetzt) <= Duration(seconds: 1),
          true); // ~1 second tolerance
      expect(savedEditedWein.beschreibung, 'Hallo');

      await db.deleteWein(savedEditedWein);
      weine = await db.getWeine();

      expect(!weine.any((wein) => wein.id == weinAddedId), true,
          reason: 'Wein wurde nicht aus der Datenbank entfernt');
    });

    test('Add a Region and make sure it is saved, then delete it again',
        () async {
      var regionen = await db.getRegionen();
      final RegionModel region = RegionModel(
        id: 0,
        name: 'TEST-REGION',
        land: "AT",
        beschreibung: "Hallo",
      );

      var createdId = await db.postRegion(region);

      expect(regionen.any((element) => element.id == createdId), false,
          reason: 'Region existiert schon, obwohl sie es noch nicht sollte');
      regionen = await db.getRegionen();
      expect(regionen.any((element) => element.id == createdId), true,
          reason: 'Region existiert nicht');
      var createdRegion =
          regionen.firstWhere((element) => element.id == createdId);

      expect(createdRegion.id, createdId);
      expect(createdRegion.name, 'TEST-REGION');
      expect(createdRegion.land, 'AT');
      expect(createdRegion.beschreibung, 'Hallo');

      // createdRegion = createdRegion.copyWith(name: 'test-region', beschreibung: null);
      // copyWith does can't set values to null
      createdRegion = RegionModel(
          id: createdRegion.id,
          name: 'test-region',
          land: createdRegion.land,
          beschreibung: null);
      await db.patchRegion(createdRegion);

      regionen = await db.getRegionen();
      var editedRegion =
          regionen.firstWhere((element) => element.id == createdId);

      expect(editedRegion.id, createdId);
      expect(editedRegion.name, 'test-region');
      expect(editedRegion.land, 'AT');
      expect(editedRegion.beschreibung, null);

      await db.deleteRegion(editedRegion);
      regionen = await db.getRegionen();
      expect(regionen.any((element) => element.id == createdId), false,
          reason: 'Region wurde nicht gelöscht');
    });

    test('Add a Sorte and make sure it is saved, then delete it again',
        () async {
      var sorten = await db.getSorten();
      final sorte = SorteModel(
        id: 0,
        name: 'TEST-SORTE ⚙🦷🎡', // idk, just make sure the encoding works
        farbe: WeinFarbe.orange,
      );

      var createdId = await db.postSorte(sorte);

      sorten = await db.getSorten();
      expect(sorten.any((element) => element.id == createdId), true,
          reason: 'Sorte existiert nicht');
      var createdSorte =
          sorten.where((element) => element.id == createdId).first;
      expect(createdSorte.name, 'TEST-SORTE ⚙🦷🎡',
          reason: 'Name stimmt nicht überein');
      expect(createdSorte.farbe, WeinFarbe.orange,
          reason: 'Farbe stimmt nicht überein');
      expect(createdSorte.id, createdId, reason: 'ID stimmt nicht überein');

      createdSorte =
          createdSorte.copyWith(name: 'test-sorte', farbe: WeinFarbe.rose);
      await db.patchSorte(createdSorte);

      sorten = await db.getSorten();
      var editedSorte = sorten.firstWhere((element) => element.id == createdId);

      expect(editedSorte.name, 'test-sorte',
          reason: 'Name stimmt nicht überein');
      expect(editedSorte.farbe, WeinFarbe.rose,
          reason: 'Farbe stimmt nicht überein');

      await db.deleteSorte(editedSorte);
      sorten = await db.getSorten();
      expect(sorten.any((element) => element.id == createdId), false,
          reason: 'Sorte wurde nicht gelöscht');
    });

    test('Add a Weinbauer and make sure it is saved, then delete it again',
        () async {
      var weinbauern = await db.getWeinbauern();
      var region = (await db.getRegionen()).first;
      final weinbauer = WeinbauerModel(
        id: 0,
        name: 'TEST-Weinbauer',
        region: region,
        beschreibung: "Hallo",
      );

      var createdId = await db.postWeinbauer(weinbauer);

      expect(weinbauern.any((element) => element.id == createdId), false,
          reason: 'Weinbauer existiert schon, obwohl er es noch nicht sollte');
      weinbauern = await db.getWeinbauern();
      expect(weinbauern.any((element) => element.id == createdId), true,
          reason: 'Weinbauer existiert nicht');
      var createdWeinbauer =
          weinbauern.firstWhere((element) => element.id == createdId);

      expect(createdWeinbauer.id, createdId);
      expect(createdWeinbauer.name, 'TEST-Weinbauer');
      expect(createdWeinbauer.region, region);
      expect(createdWeinbauer.beschreibung, 'Hallo');

      region = (await db.getRegionen()).last;

      // copyWith does can't set values to null
      createdWeinbauer = WeinbauerModel(
          id: createdWeinbauer.id,
          name: 'test-weinbauer-2',
          region: region,
          beschreibung: null);
      await db.patchWeinbauer(createdWeinbauer);

      weinbauern = await db.getWeinbauern();
      var editedWeinbauer =
          weinbauern.firstWhere((element) => element.id == createdId);

      expect(editedWeinbauer.id, createdId);
      expect(editedWeinbauer.name, 'test-weinbauer-2');
      expect(editedWeinbauer.region, region);
      expect(editedWeinbauer.beschreibung, null);

      await db.deleteWeinbauer(editedWeinbauer);
      weinbauern = await db.getWeinbauern();
      expect(weinbauern.any((element) => element.id == createdId), false,
          reason: 'Weinbauer wurde nicht gelöscht');
    });
  });
}