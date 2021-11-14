import 'package:test/test.dart';
import 'package:weindb/models/models.dart';

void main() {
  group('WeinFarbe', () {
    test('getName', () {
      expect(WeinFarbenHelper.getName(WeinFarbe.red), 'Rot');
      expect(WeinFarbenHelper.getName(WeinFarbe.rose), 'Rosé');
      expect(WeinFarbenHelper.getName(WeinFarbe.orange), 'Orange');
      expect(WeinFarbenHelper.getName(WeinFarbe.white), 'Weiß');
    });

    test('fromInt', () {
      expect(WeinFarbenHelper.fromInt(0), WeinFarbe.red);
      expect(WeinFarbenHelper.fromInt(1), WeinFarbe.white);
      expect(WeinFarbenHelper.fromInt(2), WeinFarbe.rose);
      expect(WeinFarbenHelper.fromInt(3), WeinFarbe.orange);

      // anscheinend muss man so schauen, ob das einen assertion failed
      expect(
          () => WeinFarbenHelper.fromInt(-1), throwsA(isA<AssertionError>()));

      expect(() => WeinFarbenHelper.fromInt(4), throwsA(isA<AssertionError>()));
    });

    test('toInt', () {
      expect(WeinFarbenHelper.toInt(WeinFarbe.red), 0);
      expect(WeinFarbenHelper.toInt(WeinFarbe.white), 1);
      expect(WeinFarbenHelper.toInt(WeinFarbe.rose), 2);
      expect(WeinFarbenHelper.toInt(WeinFarbe.orange), 3);
    });

    test('fromString', () {
      // Grundlegend
      expect(WeinFarbenHelper.fromString('rot'), WeinFarbe.red);
      expect(WeinFarbenHelper.fromString('weiß'), WeinFarbe.white);
      expect(WeinFarbenHelper.fromString('rosé'), WeinFarbe.rose);
      expect(WeinFarbenHelper.fromString('orange'), WeinFarbe.orange);

      // Groß-/Kleinschreibung
      expect(WeinFarbenHelper.fromString('oRaNgE'), WeinFarbe.orange);
      expect(WeinFarbenHelper.fromString('rOsE'), WeinFarbe.rose);

      // Englisch
      expect(WeinFarbenHelper.fromString('red'), WeinFarbe.red);
      expect(WeinFarbenHelper.fromString('white'), WeinFarbe.white);
      expect(WeinFarbenHelper.fromString('rose'), WeinFarbe.rose);
      // v - Sinnlos weil schonmal getestet aber egal
      expect(WeinFarbenHelper.fromString('orange'), WeinFarbe.orange);

      // Ungültige Werte
      expect(WeinFarbenHelper.fromString('IchBinKeineFarbe'), null);
      expect(WeinFarbenHelper.fromString('_white'), null);
      expect(WeinFarbenHelper.fromString('ose'), null);
    });
  });
}
