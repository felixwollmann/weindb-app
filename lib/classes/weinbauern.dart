import 'dart:convert'; // JSON <-> UTF-8
import 'package:flutter/foundation.dart'; // ChangeNotifier
import 'package:quiver/collection.dart'; // DelegatingMap
import 'package:http/http.dart' as http; // http-Aufrufe
// import 'package:equatable/equatable.dart'; // Klassen vergleichen
import 'package:weindb/classes/classes.dart';

class Weinbauern extends DelegatingMap<int, Weinbauer>
    with ChangeNotifier, publicNotify {
  Regionen? regionen;
  final Uri url = Uri.parse(base + 'weinbauer');
  final Map<int, Weinbauer> _weinbauern;

  bool showProgress = true;

  bool error = false;

  Weinbauern(this._weinbauern);

  Map<int, Weinbauer> get delegate => _weinbauern;

  Future reload({bool show = false}) async {
    try {
      showProgress = show;
      error = false;
      notifyListeners();
      var response = await http.get(url);
      if (!response.statusCode.toString().startsWith('2')) throw 'nicht 2xx';
      List decoded = jsonDecode(response.body);
      _weinbauern.clear();
      decoded.forEach((element) {
        Weinbauer weinbauer = Weinbauer.fromMap(element, this);
        this[weinbauer.id] = weinbauer;
      });
    } catch (err) {
      error = true;
    } finally {
      showProgress = false;
      notifyListeners();
    }
  }

  factory Weinbauern.get() {
    Weinbauern weinbauern = Weinbauern({});
    weinbauern.reload(show: true);
    return weinbauern;
  }

  Future<Weinbauer> add(Weinbauer newWeinbauer) async {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'name': newWeinbauer.name,
          if (newWeinbauer.region != null) 'regionen_id': newWeinbauer.region!.id,
          if (newWeinbauer.beschreibung != null)
            'beschreibung': newWeinbauer.beschreibung,
        },
      ),
    );
    Weinbauer weinbauer = Weinbauer.fromMap(jsonDecode(response.body), this);
    this[weinbauer.id] = weinbauer;
    notifyListeners();
    return weinbauer;
  }
}
