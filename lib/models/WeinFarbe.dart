part of 'models.dart';

enum WeinFarbe {
  red,
  rose,
  orange,
  white,
}


/// Abstract helper class for enum WeinFarbe
/// 
/// Methods to convert enum WeinFarbe from/to String/int
abstract class WeinFarbenHelper {
  /// Wandelt eine WeinFarbe in einen String um
  /// 
  /// Der Name toString geht irgendwie nicht also getName
  static String getName(WeinFarbe farbe) {
    switch (farbe) {
      case WeinFarbe.red:
        return 'Rot';
      case WeinFarbe.rose:
        return 'Rosé';
      case WeinFarbe.orange:
        return 'Orange';
      case WeinFarbe.white:
        return 'Weiß';
    }
  }

  /// Wandelt einen int in eine WeinFarbe um
  ///
  /// Wenn [value] > 3 oder [value] < 0, wird im debug-Modus assert ausgelöst, in der Produktion wird [WeinFarbe.red] zurückgegeben
  static WeinFarbe fromInt(int value) {
    assert(value >= 0 && value <= 3, '''
    Die Methode WeinFarbe.fromInt wurde mit einem Wert aufgerufen, der
    nicht zwischen 0 und 3 liegt. Das entspricht keiner Farbe. Der Wert war: $value''');

    switch (value) {
      case 0:
        return WeinFarbe.red; 
      case 1:
        return WeinFarbe.white;
      case 2:
        return WeinFarbe.rose;
      case 3:
        return WeinFarbe.orange;
      default:
        return WeinFarbe.red;
    }
  }

  /// convert a WeinFarbe to a int
  static int toInt(WeinFarbe farbe) {
    switch (farbe) {
      case WeinFarbe.red:
        return 0;
      case WeinFarbe.white:
        return 1;
      case WeinFarbe.rose:
        return 2;
      case WeinFarbe.orange:
        return 3;
    }
  }


  /// Wandelt einen String in eine WeinFarbe um
  /// 
  /// Sollte keine passende Farbe zugeordnet werden können, wird null zurückgegeben
  static WeinFarbe? fromString(String value) {
    Map<String, WeinFarbe> names = {
      'rot': WeinFarbe.red,
      'weiß': WeinFarbe.white,
      'rosé': WeinFarbe.rose,
      'orange': WeinFarbe.orange,
      'red': WeinFarbe.red,
      'white': WeinFarbe.white,
      'rose': WeinFarbe.rose,
      // orange ist gleich auf deutsch
    };

    return names[value.trim().toLowerCase()];

  }

}

// ************ Alter Code ****************************************************

// class WeinFarbeClass {
//   final WeinFarbe _value;

//   // Information für mich später: (Hier ein todo damit es angezeigt wird: TODO: Hier weitermachen
//   // Diese Klasse soll quasi wie eine Enum funktionieren, allerdings auch Methoden haben
//   // und nicht nur einen Wert. Bsp: fromInt, toInt, fromString, toString

//   // https://stackoverflow.com/questions/15854549/how-can-i-build-an-enum-with-dart/15854550#15854550
//   const WeinFarbeClass._set(this._value);

//   static const red = const WeinFarbeClass._set(WeinFarbe.red);
//   static const rose = const WeinFarbeClass._set(WeinFarbe.rose);
//   static const orange = const WeinFarbeClass._set(WeinFarbe.orange);
//   static const white = const WeinFarbeClass._set(WeinFarbe.white);
// }

// extension on WeinFarbe {
//   /// Wandelt einen int in eine WeinFarbe um
//   ///
//   /// Wenn [value] > 3 oder [value] < 0, wird im debug-Modus assert ausgelöst, in der Produktion wird [WeinFarbe.red] zurückgegeben
//   static WeinFarbe fromInt(int value) {
//     assert(value >= 0 && value <= 3, '''
//     Die Methode WeinFarbe.fromInt wurde mit einem Wert aufgerufen, der
//     nicht zwischen 0 und 3 liegt. Das entspricht keiner Farbe. Der Wert war: $value''');

//     switch (value) {
//       case 0:
//         return WeinFarbe.red;
//       case 1:
//         return WeinFarbe.white;
//       case 2:
//         return WeinFarbe.rose;
//       case 3:
//         return WeinFarbe.orange;
//       default:
//         return WeinFarbe.red;
//     }
//   }

//   int toInt() {
//     switch (this) {
//       case WeinFarbe.red:
//         return 0;
//       case WeinFarbe.white:
//         return 1;
//       case WeinFarbe.rose:
//         return 2;
//       case WeinFarbe.orange:
//         return 3;
//     }
//   }
// }
