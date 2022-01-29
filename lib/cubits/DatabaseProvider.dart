import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weindb/cubits/DatabaseProviderBase.dart';

import 'package:weindb/models/models.dart';

extension on http.Response {
  bool isOk() => statusCode < 300 && statusCode >= 200;
}

class DatabaseProvider extends DatabaseProviderBase {
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
  @override
  Future<List<SorteModel>> getSorten() async {
    final http.Response response = await client.get(sorteURL);
    if (!response.isOk())
      throw new Exception(
          "The server returned a status code of ${response.statusCode}.");
    final List<dynamic> decoded = jsonDecode(response.body);
    return decoded.map((e) => SorteModel.fromJson(e)).toList();
  }

  @override
  Future<List<WeinModel>> getWeine() async {
    final http.Response response = await client.get(weinURL);
    if (!response.isOk())
      throw new Exception(
          "The server returned a status code of ${response.statusCode}.");
    final List<dynamic> decoded = jsonDecode(response.body);
    return decoded.map((e) => WeinModel.fromJson(e)).toList();
  }

  @override
  Future<List<WeinbauerModel>> getWeinbauern() async {
    final http.Response response = await client.get(weinbauerURL);
    if (!response.isOk())
      throw new Exception(
          "The server returned a status code of ${response.statusCode}.");
    final List<dynamic> decoded = jsonDecode(response.body);
    return decoded.map((e) => WeinbauerModel.fromJson(e)).toList();
  }

  @override
  Future<List<RegionModel>> getRegionen() async {
    final http.Response response = await client.get(regionURL);
    if (!response.isOk())
      throw new Exception(
          "The server returned a status code of ${response.statusCode}.");
    final List<dynamic> decoded = jsonDecode(response.body);
    return decoded.map((e) => RegionModel.fromJson(e)).toList();
  }

  @override
  Future<int> postWein(WeinModel wein) async {
    final http.Response response = await client.post(
      weinURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(wein.toJson()),
    );
    if (!response.isOk())
      throw new Exception(
          "The server returned a status code of ${response.statusCode}.");
    final Map<String, dynamic> decoded = jsonDecode(response.body);
    // final WeinModel weinModel = WeinModel.fromJson(decoded);
    // Das hier geht nicht so gut, da die Antwort nicht die Felder weinbauern und sorten enthält
    // die beste Idee ist wahrscheinlich, in dieser Methode hier dann die spezifische ID nochmals zu fetchen
    // und dann das zurückzuliefern, oder die API zu verändern
    return decoded['id'] as int;
  }

  @override
  Future<void> deleteRegion(RegionModel region) {
    // TODO: implement deleteRegion
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSorte(SorteModel sorte) {
    // TODO: implement deleteSorte
    throw UnimplementedError();
  }

  @override
  Future<void> deleteWein(WeinModel wein) {
    // TODO: implement deleteWein
    throw UnimplementedError();
  }

  @override
  Future<void> deleteWeinbauer(WeinbauerModel weinbauer) {
    // TODO: implement deleteWeinbauer
    throw UnimplementedError();
  }

  @override
  Future<void> patchRegion(RegionModel region) {
    // TODO: implement patchRegion
    throw UnimplementedError();
  }

  @override
  Future<void> patchSorte(SorteModel sorte) {
    // TODO: implement patchSorte
    throw UnimplementedError();
  }

  @override
  Future<void> patchWein(WeinModel wein) {
    // TODO: implement patchWein
    throw UnimplementedError();
  }

  @override
  Future<void> patchWeinbauer(WeinbauerModel weinbauer) {
    // TODO: implement patchWeinbauer
    throw UnimplementedError();
  }

  @override
  Future<int> postRegion(RegionModel region) {
    // TODO: implement postRegion
    throw UnimplementedError();
  }

  @override
  Future<int> postSorte(SorteModel sorte) {
    // TODO: implement postSorte
    throw UnimplementedError();
  }

  @override
  Future<int> postWeinbauer(WeinbauerModel weinbauer) {
    // TODO: implement postWeinbauer
    throw UnimplementedError();
  }
}
