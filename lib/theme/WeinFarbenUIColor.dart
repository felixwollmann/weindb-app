import 'package:flutter/material.dart';
import 'package:weindb/models/models.dart';

class WeinFarbenUIColor {
  static Color getColor(WeinFarbe weinFarbe) {
    switch (weinFarbe) {
      
      // no breaks needed since the method returns

      // TODO: Improve the color scheme of these colors
      case WeinFarbe.red:
        return Colors.red[900]!;
      case WeinFarbe.rose:
        return Colors.pink[300]!;
      case WeinFarbe.orange:
        return Colors.amberAccent[700]!;
      case WeinFarbe.white:
        return Colors.amber[200]!;
    }
  }
}