import 'dart:convert'; // JSON <-> UTF-8
import 'package:flutter/foundation.dart'; // ChangeNotifier
import 'package:quiver/collection.dart'; // DelegatingMap
import 'package:http/http.dart' as http; // http-Aufrufe
// import 'package:equatable/equatable.dart'; // Klassen vergleichen
import 'package:weindb/classes/classes.dart';

class Weine extends DelegatingMap<int, Wein> with ChangeNotifier, publicNotify {
  Sorten? sorten;
  Weinbauern? weinbauern;
  final Uri url = Uri.parse(base + 'wein');
  final Map<int, Wein> _weine;

  bool showProgress = true;

  bool error = false;

  Weine(this._weine);

  Map<int, Wein> get delegate => _weine;

  Future reload({bool show = false}) async {
    try {
      showProgress = show;
      error = false;
      notifyListeners();
      var response = await http.get(url);
      if (!response.statusCode.toString().startsWith('2')) throw 'nicht 2xx';
      List decoded = jsonDecode(response.body);
      _weine.clear();
      decoded.forEach((element) {
        Wein.fromMap(element, this);
      });
    } catch (err) {
      error = true;
    } finally {
      showProgress = false;
      notifyListeners();
    }
  }

  factory Weine.get({Uri? overridenUrl}) {
    Weine weine = Weine({});
    weine.reload(show: true,);
    return weine;
  }

  Future<Wein> add(Wein newWein) async {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'name': newWein.name,
          'sorten_id': newWein.sorte.id,
          'anzahl': newWein.anzahl,
          'getrunken': newWein.getrunken,
          if (newWein.jahr != null) 'jahr': newWein.jahr,
          if (newWein.weinbauer != null) 'weinbauern_id': newWein.weinbauer!.id,
          if (newWein.gekauft != null) 'gekauft': newWein.gekauft!.millisecondsSinceEpoch,
          if (newWein.beschreibung != null) 'beschreibung': newWein.beschreibung,
          if (newWein.inhalt != null) 'inhalt': newWein.inhalt,
          if (newWein.fach != null) 'fach': newWein.fach,
          if (newWein.preis != null) 'preis': newWein.preis,
        },
      ),
    );
    Wein wein = Wein.fromMap(jsonDecode(response.body), this);
    this[wein.id] = wein;
    notifyListeners();
    return wein;
  }
}