import 'package:test/test.dart';
import 'package:weindb/models/models.dart';

void main() {
  group('SorteModel', () {
    test('Erstellung über Konstruktor', () {
      final sorte = SorteModel(
        id: 1,
        name: 'MeineSorte',
        farbe: WeinFarbe.red,
      );

      expect(sorte.id, 1);
      expect(sorte.name, 'MeineSorte');
      expect(sorte.farbe, WeinFarbe.red);

      final sorteZumTesten = SorteModel(
        id: 1,
        name: 'MeineSorte',
        farbe: WeinFarbe.red,
      );

      expect(sorte == sorteZumTesten, true);
    });

    test('fromJson', () {
      final sorte1 = SorteModel.fromJson({
        'id': 1,
        'name': 'MeineSorte',
        'farbe': 0,
      });

      expect(sorte1.id, 1);
      expect(sorte1.name, 'MeineSorte');
      expect(sorte1.farbe, WeinFarbe.red);

      final sorte2 = SorteModel.fromJson({
        'id': 2,
        'name': 'MeineSorte',
        'farbe': 1,
      });

      expect(sorte2.id, 2);
      expect(sorte2.name, 'MeineSorte');
      expect(sorte2.farbe, WeinFarbe.white);

      final sorte3 = SorteModel.fromJson({
        'id': 3,
        'name': 'MeineSorte',
        'farbe': 2,
      });

      expect(sorte3.id, 3);
      expect(sorte3.name, 'MeineSorte');
      expect(sorte3.farbe, WeinFarbe.rose);

      final sorte4 = SorteModel.fromJson({
        'id': 4,
        'name': 'MeineSorte',
        'farbe': 3,
      });

      expect(sorte4.id, 4);
      expect(sorte4.name, 'MeineSorte');
      expect(sorte4.farbe, WeinFarbe.orange);
    });

    test('toJson', () {
      final sorte1 = SorteModel(
        id: 1,
        name: 'MeineSorte',
        farbe: WeinFarbe.red,
      );

      expect(sorte1.toJson(), {
        'id': 1,
        'name': 'MeineSorte',
        'farbe': 0,
      });

      final sorte2 = SorteModel(
        id: 2,
        name: 'MeineSorte',
        farbe: WeinFarbe.white,
      );

      expect(sorte2.toJson(), {
        'id': 2,
        'name': 'MeineSorte',
        'farbe': 1,
      });

      final sorte3 = SorteModel(
        id: 3,
        name: 'MeineSorte',
        farbe: WeinFarbe.rose,
      );

      expect(sorte3.toJson(), {
        'id': 3,
        'name': 'MeineSorte',
        'farbe': 2,
      });

      final sorte4 = SorteModel(
        id: 4,
        name: 'MeineSorte',
        farbe: WeinFarbe.orange,
      );

      expect(sorte4.toJson(), {
        'id': 4,
        'name': 'MeineSorte',
        'farbe': 3,
      });
    });
  });
}
