export 'package:weindb/classes/wein.dart';
export 'package:weindb/classes/weine.dart';
export 'package:weindb/classes/weinbauer.dart';
export 'package:weindb/classes/weinbauern.dart';
export 'package:weindb/classes/sorte.dart';
export 'package:weindb/classes/sorten.dart';
export 'package:weindb/classes/region.dart';
export 'package:weindb/classes/regionen.dart';
export './sharedPrefs.dart';

// import 'package:weindb/classes/wein.dart';
// import 'package:weindb/classes/weine.dart';
// import 'package:weindb/classes/weinbauer.dart';
// import 'package:weindb/classes/weinbauern.dart';
// import 'package:weindb/classes/sorte.dart';
// import 'package:weindb/classes/sorten.dart';
// import 'package:weindb/classes/region.dart';
// import 'package:weindb/classes/regionen.dart';

// import 'dart:convert'; // JSON <-> UTF-8
import 'package:flutter/foundation.dart'; // ChangeNotifier
import 'package:weindb/settings_generation/settings_generation.dart';
// import 'package:quiver/collection.dart'; // DelegatingMap
// import 'package:http/http.dart' as http; // http-Aufrufe
// import 'package:equatable/equatable.dart'; // Klassen vergleichen

// import 'package:shared_preferences/shared_preferences.dart';


String base = AppSettingsNoContext.getString('api-host'); // TODO: shared-preferences für host
// String base = 'http://192.168.100.10/'; 


// class Weine<Wein> {
//   List<Wein> _list;
//   opre
// }


mixin publicNotify on ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}












