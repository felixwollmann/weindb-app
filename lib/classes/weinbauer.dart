import 'dart:convert'; // JSON <-> UTF-8
// import 'package:flutter/foundation.dart'; // ChangeNotifier
// import 'package:quiver/collection.dart'; // DelegatingMap
import 'package:http/http.dart' as http; // http-Aufrufe
import 'package:equatable/equatable.dart'; // Klassen vergleichen
import 'package:weindb/classes/classes.dart';

class Weinbauer extends Equatable {
  final Weinbauern _weinbauern;
  final int id;
  final Region? region;
  final String name;
  final String? beschreibung;
  final double? relevance;

  @override
  List<Object?> get props => [id, region, name, beschreibung];

  Weinbauer(
    this._weinbauern, {
    required this.id,
    this.region,
    required this.name,
    this.beschreibung,
    this.relevance,
  });

  factory Weinbauer.fromMap(Map data, Weinbauern weinbauern) {
    // bool regionExists = regionen.containsKey(data['regionen_id']);
    Region? region;
    Regionen regionen = weinbauern.regionen!;
    if (regionen.containsKey(data['regionen_id'])) {
      region = regionen[data['regionen_id']];
    } else if (data['regionen'] != null) {
      region = Region.fromMap(data['regionen'], regionen);
      regionen[data['regionen_id']] = region;
    }
    return Weinbauer(weinbauern,
        id: data['id'],
        name: data['name'],
        region: region,
        beschreibung: data['beschreibung'],
        relevance: data['relevance'] == null
            ? null
            : double.tryParse(data['relevance'].toString()));
  }

  Uri get url => Uri.parse(base + 'weinbauer/$id');

  Future<http.Response> delete() async {
    var response = await http.delete(url);
    _weinbauern.remove(id);
    return response;
  }

  Future<void> reload() async {
    var response = await http.get(url);
    Weinbauer.fromMap(jsonDecode(response.body), _weinbauern);
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
          if (this.region != null) 'regionen_id': this.region!.id,
          if (this.beschreibung != null) 'beschreibung': this.beschreibung,
        },
      ),
    );

    _weinbauern[this.id] = this;
    _weinbauern.notify();
  }
}
