import 'package:test/test.dart';
import 'package:weindb/models/models.dart';

void main() {
  group('RegionModel', () {
    test('Erstellung über Konstruktor', () {
      final region = RegionModel(
        id: 1,
        name: 'MeineRegion',
        land: 'AT',
      );

      expect(region.id, 1);
      expect(region.name, 'MeineRegion');
      expect(region.land, 'AT');
      expect(region.beschreibung, null);

      final region1 = RegionModel(
        id: 1,
        name: 'MeineRegion',
        land: 'DE',
        beschreibung: 'Meine Beschreibung',
      );

      expect(region1.id, 1);
      expect(region1.name, 'MeineRegion');
      expect(region1.land, 'DE');
      expect(region1.beschreibung, 'Meine Beschreibung');

      final auchRegion1 = RegionModel(
        id: 1,
        name: 'MeineRegion',
        land: 'DE',
        beschreibung: 'Meine Beschreibung',
      );

      expect(region1 == auchRegion1, true);
    });

    test('fromJson', () {
      final region1 = RegionModel.fromJson({
        'id': 1,
        'name': 'MeineRegion',
        'land': 'AT',
      });

      expect(region1.id, 1);
      expect(region1.name, 'MeineRegion');
      expect(region1.land, 'AT');

      final sorte2 = RegionModel.fromJson({
        'id': 2,
        'name': 'MeineRegion2',
        'land': 'DE',
        'beschreibung': 'Meine Beschreibung',
      });

      expect(sorte2.id, 2);
      expect(sorte2.name, 'MeineRegion2');
      expect(sorte2.land, 'DE');
      expect(sorte2.beschreibung, 'Meine Beschreibung');

      // TODO: Was passiert bei einem ungültigen JSON?
    });

    test('toJson', () {
      final region1 = RegionModel(
        id: 1,
        name: 'MeineRegion',
        land: 'AT',
      );

      expect(region1.toJson(), {
        'id': 1,
        'name': 'MeineRegion',
        'land': 'AT',
        'beschreibung': null
      });

      final region2 = RegionModel(
        id: 2,
        name: 'MeineRegion2',
        land: 'DE',
        beschreibung: 'Meine Beschreibung',
      );

      expect(region2.toJson(), {
        'id': 2,
        'name': 'MeineRegion2',
        'land': 'DE',
        'beschreibung': 'Meine Beschreibung',
      });
    });
  });
}
