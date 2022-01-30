import 'dart:convert';

import 'package:http/http.dart' as http;
// import 'package:weindb/classes/classes.dart';
import 'package:weindb/cubits/DatabaseProviderBase.dart';

import 'package:weindb/models/models.dart';

extension on http.Response {
  /// whether the status code is ok (between 200 and 300)
  bool isOk() => statusCode < 300 && statusCode >= 200;

  /// If the response is not ok, throw an exception
  void checkOk() {
    if (!isOk()) {
      throw new Exception("The server returned a status code of $statusCode.");
    }
  }
}

class DatabaseProvider extends DatabaseProviderBase {
  String baseURL;
  DatabaseProvider({
    this.baseURL = "http://192.168.100.10/",
  });
  // TODO: optimieren
  Uri get weinURL => Uri.parse(baseURL + "wein/");
  Uri get sorteURL => Uri.parse(baseURL + "sorte/");
  Uri get weinbauerURL => Uri.parse(baseURL + "weinbauer/");
  Uri get regionURL => Uri.parse(baseURL + "region/");
  http.Client client = new http.Client();

  /// get a generic unique id like '[base][id]/'
  static Uri _getGenericUniqueURL(Uri base, int id) {
    return Uri.parse('$base$id/');
  }

  /// get the URL of a wein (eg. http://192.168.100.10/wein/10/)
  Uri _getUniqueWeinURL(WeinModel wein) {
    return _getGenericUniqueURL(weinURL, wein.id);
  }

  /// get the URL of a weinbauer (eg. http://192.168.100.10/weinbauer/10/)
  Uri _getUniqueWeinbauerURL(WeinbauerModel weinbauer) {
    return _getGenericUniqueURL(weinbauerURL, weinbauer.id);
  }

  /// get the URL of a sorte (eg. http://192.168.100.10/sorte/10/)
  Uri _getUniqueSorteURL(SorteModel sorte) {
    return _getGenericUniqueURL(sorteURL, sorte.id);
  }

  /// get the URL of a region (eg. http://192.168.100.10/region/10/)
  Uri _getUniqueRegionURL(RegionModel region) {
    return _getGenericUniqueURL(regionURL, region.id);
  }

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
    response.checkOk();
    final List<dynamic> decoded = jsonDecode(response.body);
    return decoded.map((e) => SorteModel.fromJson(e)).toList();
  }

  @override
  Future<List<WeinModel>> getWeine() async {
    final http.Response response = await client.get(weinURL);
    response.checkOk();
    final List<dynamic> decoded = jsonDecode(response.body);
    return decoded.map((e) => WeinModel.fromJson(e)).toList();
  }

  @override
  Future<List<WeinbauerModel>> getWeinbauern() async {
    final http.Response response = await client.get(weinbauerURL);
    response.checkOk();
    final List<dynamic> decoded = jsonDecode(response.body);
    return decoded.map((e) => WeinbauerModel.fromJson(e)).toList();
  }

  @override
  Future<List<RegionModel>> getRegionen() async {
    final http.Response response = await client.get(regionURL);
    response.checkOk();
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
    response.checkOk();
    final Map<String, dynamic> decoded = jsonDecode(response.body);
    // final WeinModel weinModel = WeinModel.fromJson(decoded);
    // Das hier geht nicht so gut, da die Antwort nicht die Felder weinbauern und sorten enthält
    // die beste Idee ist wahrscheinlich, in dieser Methode hier dann die spezifische ID nochmals zu fetchen
    // und dann das zurückzuliefern, oder die API zu verändern
    return decoded['id'] as int;
  }

  @override
  Future<void> deleteRegion(RegionModel region) async {
    await client.delete(_getUniqueRegionURL(region))
      ..checkOk();
  }

  @override
  Future<void> deleteSorte(SorteModel sorte) async {
    await client.delete(_getUniqueSorteURL(sorte))
      ..checkOk();
  }

  @override
  Future<void> deleteWein(WeinModel wein) async {
    await client.delete(_getUniqueWeinURL(wein))
      ..checkOk();
  }

  @override
  Future<void> deleteWeinbauer(WeinbauerModel weinbauer) async {
    await client.delete(_getUniqueWeinbauerURL(weinbauer))
      ..checkOk();
  }

  @override
  Future<void> patchRegion(RegionModel region) async {
    final http.Response response = await client.patch(
      _getUniqueRegionURL(region),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(region.toJson()),
    );
    response.checkOk();
  }

  @override
  Future<void> patchSorte(SorteModel sorte) async {
    final http.Response response = await client.patch(
      _getUniqueSorteURL(sorte),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(sorte.toJson()),
    );
    response.checkOk();
  }

  @override
  Future<void> patchWein(WeinModel wein) async {
    final http.Response response = await client.patch(
      _getUniqueWeinURL(wein),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(wein.toJson()),
    );
    response.checkOk();
  }

  @override
  Future<void> patchWeinbauer(WeinbauerModel weinbauer) async {
    final http.Response response = await client.patch(
      _getUniqueWeinbauerURL(weinbauer),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(weinbauer.toJson()),
    );
    response.checkOk();
  }

  @override
  Future<int> postRegion(RegionModel region) async {
    final http.Response response = await client.post(
      regionURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(region.toJson()),
    );
    response.checkOk();
    final Map<String, dynamic> decoded = jsonDecode(response.body);
    return decoded['id'] as int;
  }

  @override
  Future<int> postSorte(SorteModel sorte) async {
    final http.Response response = await client.post(
      sorteURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(sorte.toJson()),
    );
    response.checkOk();
    final Map<String, dynamic> decoded = jsonDecode(response.body);
    return decoded['id'] as int;
  }

  @override
  Future<int> postWeinbauer(WeinbauerModel weinbauer) async {
    final http.Response response = await client.post(
      weinbauerURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(weinbauer.toJson()),
    );
    response.checkOk();
    final Map<String, dynamic> decoded = jsonDecode(response.body);
    return decoded['id'] as int;
  }
}