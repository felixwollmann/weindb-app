import 'dart:convert'; // JSON <-> UTF-8
import 'package:flutter/foundation.dart'; // ChangeNotifier
import 'package:quiver/collection.dart'; // DelegatingMap
import 'package:http/http.dart' as http; // http-Aufrufe
// import 'package:equatable/equatable.dart'; // Klassen vergleichen
import 'package:weindb/classes/classes.dart';

class Sorten extends DelegatingMap<int, Sorte>
    with ChangeNotifier, publicNotify {
  final Uri url = Uri.parse(base + 'sorte');
  final Map<int, Sorte> _sorten;

  bool showProgress = true;

  bool error = false;

  Sorten(this._sorten);

  Map<int, Sorte> get delegate => _sorten;

  Future reload({bool show = false}) async {
    try {
      showProgress = show;
      error = false;
      notifyListeners();
      var response = await http.get(url);
      if (!response.statusCode.toString().startsWith('2')) throw 'nicht 2xx';
      List decoded = jsonDecode(response.body);
      _sorten.clear();
      decoded.forEach((element) {
        Sorte sorte = Sorte.fromMap(element, this);
        this[sorte.id] = sorte;
      });
    } catch (err) {
      error = true;
    } finally {
      showProgress = false;
      notifyListeners();
    }
  }

  factory Sorten.get() {
    Sorten sorten = Sorten({});
    sorten.reload(show: true);
    return sorten;
  }

  Future<Sorte> add(Sorte newSorte) async {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'name': newSorte.name,
          'farbe': newSorte.farbe,
        },
      ),
    );
    Sorte sorte = Sorte.fromMap(jsonDecode(response.body), this);
    this[sorte.id] = sorte;
    notifyListeners();
    return sorte;
  }
}
