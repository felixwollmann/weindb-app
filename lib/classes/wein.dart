import 'dart:convert'; // JSON <-> UTF-8
// import 'package:flutter/foundation.dart'; // ChangeNotifier
// import 'package:quiver/collection.dart'; // DelegatingMap
import 'package:http/http.dart' as http; // http-Aufrufe
import 'package:equatable/equatable.dart'; // Klassen vergleichen
import 'package:weindb/classes/classes.dart';

/// Ein Wein in der Datenbank
class Wein extends Equatable {
  final Weine _weine;

  /// Id des Weins in der Datenbank
  final int id;

  /// Der Name des Weins
  final String name;

  /// Sorte des Weins
  final Sorte sorte;

  /// Wie viele ungeöffnete/ungetrunkene Flaschen des Weines noch vorhanden sind
  final int anzahl;

  /// Wie viele Flaschen schon getrunken wurden
  final int getrunken;

  /// Jahrgang (?) des Weins
  final int? jahr;

  /// Weinbauer des Weins
  final Weinbauer? weinbauer;

  /// Datums (aka ungenauer Zeitstempel) des Kaufs
  final DateTime? gekauft;

  /// Beschreibung des Weins
  final String? beschreibung;

  /// Inhalt in l (Liter)
  final double? inhalt;

  /// Nummer des Faches, in der sich der Wein befindet
  final int? fach;

  /// Preis des Weins in €
  final double? preis;

  /// Relevanz des Weins, wenn er bei einer Suche zurückgegeben wurde
  final double? relevance;

  @override
  List<Object?> get props => [
        id,
        name,
        sorte,
        anzahl,
        getrunken,
        jahr,
        weinbauer,
        gekauft,
        beschreibung,
        inhalt,
        fach,
        preis
      ];

  Wein(this._weine,
      {required this.id,
      required this.name,
      required this.sorte,
      required this.anzahl,
      required this.getrunken,
      this.jahr,
      this.weinbauer,
      this.gekauft,
      this.beschreibung,
      this.inhalt,
      this.fach,
      this.preis,
      this.relevance});

  factory Wein.fromMap(
    Map data,
    Weine weine,
  ) {
    var sorten = weine.sorten!;
    var weinbauern = weine.weinbauern!;
    // var regionen = weinbauern.regionen!;
    Sorte sorte;
    if (sorten.containsKey(data['sorten_id'])) {
      sorte = sorten[data['sorten_id']]!;
    } else {
      sorte = Sorte.fromMap(data['sorten'], sorten);
      sorten[data['sorten_id']] = sorte;
    }

    Weinbauer? weinbauer;
    if (data['weinbauern'] != null) {
      if (weinbauern.containsKey(data['weinbauern_id'])) {
        weinbauer = weinbauern[data['weinbauern_id']]!;
      } else {
        weinbauer = Weinbauer.fromMap(data['weinbauern'], weinbauern);
        weinbauern[data['weinbauern_id']] = weinbauer;
      }
    }

    Wein wein = Wein(weine,
        id: data['id'],
        name: data['name'],
        sorte: sorte,
        anzahl: data['anzahl'],
        getrunken: data['getrunken'],
        jahr: data['jahr'],
        weinbauer: weinbauer,
        gekauft: DateTime.tryParse(data['gekauft'] ?? ''),
        beschreibung: data['beschreibung'],
        inhalt: data['inhalt'] == null
            ? null
            : double.tryParse(data['inhalt'].toString()),
        fach: data['fach'],
        preis: data['preis'] == null
            ? null
            : double.tryParse(data['preis'].toString()),
        relevance: data['relevance'] == null
            ? null
            : double.tryParse(data['relevance'].toString()));
    weine[wein.id] = wein;
    weine.notify();
    return wein;
  }

  Uri get url => Uri.parse(base + 'wein/$id');

  Future<void> drink() async {
    var response = await http.patch(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'anzahl': anzahl - 1, 'getrunken': getrunken + 1}));
    if (!response.statusCode.toString().startsWith('2')) throw 'nicht 2xx';

    _weine[this.id] = Wein(
      _weine,
      id: this.id,
      name: this.name,
      sorte: this.sorte,
      anzahl: this.anzahl - 1,
      getrunken: this.getrunken + 1,
      jahr: this.jahr,
      weinbauer: this.weinbauer,
      gekauft: this.gekauft,
      beschreibung: this.beschreibung,
      inhalt: this.inhalt,
      fach: this.fach,
      preis: this.preis,
    );
    _weine.notify();
  }

  Future<http.Response> delete() async {
    var response = await http.delete(url);
    _weine.remove(id);
    _weine.notify();
    return response;
  }

  /// DOES NOT WORK
  /// Das zu implementieren dauert etwas länger, also lass ich es jetzt einfach weg
  /// TODO: Reload von Wein, Sorte, usw.....
  Future<void> reload() async {
    var response = await http.get(url);
    Wein.fromMap(jsonDecode(response.body), _weine);
  }

  void save() async {
    // ignore: unused_local_variable
    var response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'name': this.name,
          'sorten_id': this.sorte.id,
          'anzahl': this.anzahl,
          'getrunken': this.getrunken,
          if (this.jahr != null) 'jahr': this.jahr,
          if (this.weinbauer != null) 'weinbauern_id': this.weinbauer!.id,
          if (this.gekauft != null)
            'gekauft': this.gekauft!.millisecondsSinceEpoch,
          if (this.beschreibung != null) 'beschreibung': this.beschreibung,
          if (this.inhalt != null) 'inhalt': this.inhalt,
          if (this.fach != null) 'fach': this.fach,
          if (this.preis != null) 'preis': this.preis,
        },
      ),
    );

    _weine[this.id] = this;
    _weine.notify();
  }
}
