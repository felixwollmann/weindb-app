import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:weindb/models/models.dart';

extension on http.Response {
  bool isOk() => statusCode < 300 && statusCode >= 200;
}

class DatabaseProvider {
  String baseURL;
  DatabaseProvider({
    this.baseURL = "http://192.168.100.10/",
  });
  // TODO: optimieren
  Uri get weinURL => Uri.parse(baseURL + "wein");
  Uri get sorteURL => Uri.parse(baseURL + "sorte");
  Uri get weinbauerURL => Uri.parse(baseURL + "weinbauer");
  Uri get regionURL => Uri.parse(baseURL + "region");
  http.Client client = new http.Client();

  // delete
  // drink (wein)
  // reload alles
  // reload einzeln
  // save
  // add

  // post
  // get
  // // get id // später
  // delete
  // patch

  // drink

  // sorte
  // wein
  // weinbauer
  // region

  Future<List<SorteModel>> getSorten() async {
    final http.Response response = await client.get(sorteURL);
    if (!response.isOk())
      throw new Exception(
          "The server returned a status code of ${response.statusCode}.");
    final List<dynamic> decoded = jsonDecode(response.body);
    return decoded.map((e) => SorteModel.fromJson(e)).toList();
  }

  Future<List<WeinModel>> getWeine() async {
    final http.Response response = await client.get(weinURL);
    if (!response.isOk())
      throw new Exception(
          "The server returned a status code of ${response.statusCode}.");
    final List<dynamic> decoded = jsonDecode(response.body);
    return decoded.map((e) => WeinModel.fromJson(e)).toList();
  }

  Future<List<WeinbauerModel>> getWeinbauern() async {
    final http.Response response = await client.get(weinbauerURL);
    if (!response.isOk())
      throw new Exception(
          "The server returned a status code of ${response.statusCode}.");
    final List<dynamic> decoded = jsonDecode(response.body);
    return decoded.map((e) => WeinbauerModel.fromJson(e)).toList();
  }

  Future<List<RegionModel>> getRegionen() async {
    final http.Response response = await client.get(regionURL);
    if (!response.isOk())
      throw new Exception(
          "The server returned a status code of ${response.statusCode}.");
    final List<dynamic> decoded = jsonDecode(response.body);
    return decoded.map((e) => RegionModel.fromJson(e)).toList();
  }
}
