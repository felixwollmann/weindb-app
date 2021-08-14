import 'package:flutter/material.dart';

/// Diese Colors-Sache ist kopiert von [hier](https://github.com/Netlob/zeta/blob/master/lib/constants/app_theme.dart) (Zeta App von Sjoerd)
class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class

  /// Rot ._.
  static const Map<int, Color> primary = const <int, Color>{
    50: const Color(0xFFfce8ea),
    100: const Color(0xFFf7c5c8),
    200: const Color(0xFFe08e8a),
    300: const Color(0xFFcf645e),
    400: const Color(0xFFd34237),
    500: const Color(0xFFd32f18),
    600: const Color(0xFFc52419),
    700: const Color(0xFFb51915),
    800: const Color(0xFFa8110d),
    900: const Color(0xFF990000)
  };

  /// Farben für den Light Mode

}

extension WineColorScheme on ColorScheme {
  // Color get white => const Color(0xFFF6F392);
  // Color get white => brightness == Brightness.light ? const Color(0xFFF6F392) : const Color(0x2228a745); // so gehts auch mit dark mode
  // Color get onWhite => Colors.black;
  // Color get red => const Color(0xFF640918);
  // Color get onRed => Colors.white;
  // Color get rose => const Color(0xFFF06270);
  // Color get onRose => Colors.black;

  // Map<String, Color> get wine => {
  //   "white": Color(0xFFF6F392),
  //   "onwhite": Colors.black,
  //   "red": Color(0xFF640918),
  //   "onred": Colors.white,
  //   "rose": Color(0xFFF06270),
  //   "onrose": Colors.black,
  // };

  Color wein(String name) {
    Map<String, Color> farben = {
      "white": Colors.amber[200]!,
      "red": Colors.red[900]!,
      "rose": Colors.pink[300]!,
      "orange": Colors.amberAccent[700]!,
    };
    assert(farben[name] != null);
    return farben[name] ?? farben['red']!;
  }

  Color onWein(String name) {
    Map<String, Color> farben = {
      "white": Colors.black,
      "red": Colors.white,
      "rose": Colors.black,
      "orange": Colors.black,
    };
    assert(farben[name] != null);
    return farben[name] ?? farben['red']!;
  }
}
