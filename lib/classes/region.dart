import 'dart:convert'; // JSON <-> UTF-8
// import 'package:flutter/foundation.dart'; // ChangeNotifier
// import 'package:quiver/collection.dart'; // DelegatingMap
import 'package:http/http.dart' as http; // http-Aufrufe
import 'package:equatable/equatable.dart'; // Klassen vergleichen
import 'package:weindb/classes/classes.dart';

class Region extends Equatable {
  final Regionen _regionen;
  final int id;
  final String name;
  final String land;
  final String? beschreibung;
  final double? relevance;

  @override
  List<Object?> get props => [id, name, land, beschreibung];

  Region(
    this._regionen, {
    required this.id,
    required this.name,
    required this.land,
    this.beschreibung,
    this.relevance,
  });

  factory Region.fromMap(Map data, Regionen regionen) {
    return Region(
      regionen,
      id: data['id'],
      name: data['name'],
      land: data['land'],
      beschreibung: data['beschreibung'],
      relevance: data['relevance'] == null
            ? null
            : double.tryParse(data['relevance'].toString())
    );
  }

  Uri get url => Uri.parse(base + 'region/$id');

  Future<http.Response> delete() async {
    var response = await http.delete(url);
    _regionen.remove(id);
    return response;
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
          'land': this.land,
          if (this.beschreibung != null) 'beschreibung': this.beschreibung,
        },
      ),
    );

    _regionen[this.id] = this;
    _regionen.notify();
  }
}
