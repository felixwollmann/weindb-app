import 'dart:convert'; // JSON <-> UTF-8
import 'package:flutter/foundation.dart'; // ChangeNotifier
// import 'package:quiver/collection.dart'; // DelegatingMap
import 'package:http/http.dart' as http; // http-Aufrufe
import 'package:equatable/equatable.dart'; // Klassen vergleichen
import 'package:weindb/classes/classes.dart';

class Sorte extends Equatable {
  final Sorten _sorten;
  final int id;
  final String name;
  final int farbe;
  final double? relevance;

  @override
  List<Object> get props => [id, name, farbe];

  String get farbenName {
    assert(farbe == 0 || farbe == 1 || farbe == 2 || farbe == 3,
        'Farbe muss entweder rot, weiß, oder rosé sein');
    switch (farbe) {
      case 0:
        return 'red';
      case 1:
        return 'white';
      case 2:
        return 'rose';
      case 3:
        return 'orange';
      default:
        throw ErrorDescription(
            'Farbe dieser Sorte ist weder rot, weiß noch rosé');
    }
  }

  String get humanFarbenName {
    assert(farbe == 0 || farbe == 1 || farbe == 2 || farbe == 3,
        'Farbe muss entweder rot, weiß, oder rosé sein');
    switch (farbe) {
      case 0:
        return 'rot';
      case 1:
        return 'weiß';
      case 2:
        return 'rosé';
      case 3:
        return 'orange';
      default:
        throw ErrorDescription(
            'Farbe dieser Sorte ist weder rot, weiß noch rosé');
    }
  }

  static String deutscherFarbenName(int farbe) {
    assert(farbe == 0 || farbe == 1 || farbe == 2 || farbe == 3,
        'Farbe muss entweder rot, weiß, oder rosé sein');
    switch (farbe) {
      case 0:
        return 'rot';
      case 1:
        return 'weiß';
      case 2:
        return 'rosé';
      case 3:
        return 'orange';
      default:
        throw ErrorDescription(
            'Farbe dieser Sorte ist weder rot, weiß noch rosé');
    }
  }

  Sorte(
    this._sorten, {
    required this.id,
    required this.name,
    required this.farbe,
    this.relevance
  });

  factory Sorte.fromMap(Map data, Sorten sorten) {
    return Sorte(
      sorten,
      id: data['id'],
      name: data['name'],
      farbe: data['farbe'],
      relevance: data['relevance'] == null
            ? null
            : double.tryParse(data['relevance'].toString())
    );
  }

  Uri get url => Uri.parse(base + 'sorte/$id');

  Future<http.Response> delete() async {
    var response = await http.delete(url);
    _sorten.remove(id);
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
          'farbe': this.farbe,
        },
      ),
    );

    _sorten[this.id] = this;
    _sorten.notify();
  }
}
