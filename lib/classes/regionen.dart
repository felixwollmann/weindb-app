import 'dart:convert'; // JSON <-> UTF-8
import 'package:flutter/foundation.dart'; // ChangeNotifier
import 'package:quiver/collection.dart'; // DelegatingMap
import 'package:http/http.dart' as http; // http-Aufrufe
// import 'package:equatable/equatable.dart'; // Klassen vergleichen
import 'package:weindb/classes/classes.dart';


class Regionen extends DelegatingMap<int, Region> 
    with ChangeNotifier, publicNotify {
  final Uri url = Uri.parse(base + 'region');
  final Map<int, Region> _regionen;

  bool showProgress = true;

  bool error = false;

  Regionen(this._regionen);

  Map<int, Region> get delegate => _regionen;

  Future reload({bool show = false}) async {
    try {
      showProgress = show;
      error = false;
      notifyListeners();
      var response = await http.get(url);
      if (!response.statusCode.toString().startsWith('2')) throw 'nicht 2xx';
      List decoded = jsonDecode(response.body);
      this.clear();
      decoded.forEach((element) {
        Region region = Region.fromMap(element, this);
        this[region.id] = region;
      });
    } catch (err) {
      error = true;
    } finally {
      showProgress = false;
      notifyListeners();
    }
  }

  factory Regionen.get() {
    Regionen regionen = Regionen({});
    regionen.reload(show: true);
    return regionen;
  }

  Future<Region> add(Region newRegion) async {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'name': newRegion.name,
          'land': newRegion.land,
          if (newRegion.beschreibung != null) 'beschreibung': newRegion.beschreibung,
        },
      ),
    );
    Region region = Region.fromMap(jsonDecode(response.body), this);
    this[region.id] = region;
    notifyListeners();
    return region;
  }
}