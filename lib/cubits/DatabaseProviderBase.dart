import 'package:weindb/models/models.dart';

abstract class DatabaseProviderBase {
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

  Future<List<WeinModel>> getWeine();
  Future<List<SorteModel>> getSorten();
  Future<List<WeinbauerModel>> getWeinbauern();
  Future<List<RegionModel>> getRegionen();

  // return the ids of the newly created element
  Future<int> postWein(WeinModel wein);
  Future<int> postSorte(SorteModel sorte);
  Future<int> postWeinbauer(WeinbauerModel weinbauer);
  Future<int> postRegion(RegionModel region);

  // delete elements
  Future<void> deleteWein(WeinModel wein);
  Future<void> deleteSorte(SorteModel sorte);
  Future<void> deleteWeinbauer(WeinbauerModel weinbauer);
  Future<void> deleteRegion(RegionModel region);

  // edit element aka patch
  Future<void> patchWein(WeinModel wein);
  Future<void> patchSorte(SorteModel sorte);
  Future<void> patchWeinbauer(WeinbauerModel weinbauer);
  Future<void> patchRegion(RegionModel region);

  // Future<List<SorteModel>> getSorten() async {
  //   final http.Response response = await client.get(sorteURL);
  //   if (!response.isOk())
  //     throw new Exception(
  //         "The server returned a status code of ${response.statusCode}.");
  //   final List<dynamic> decoded = jsonDecode(response.body);
  //   return decoded.map((e) => SorteModel.fromJson(e)).toList();
  // }

  // Future<List<WeinModel>> getWeine() async {
  //   final http.Response response = await client.get(weinURL);
  //   if (!response.isOk())
  //     throw new Exception(
  //         "The server returned a status code of ${response.statusCode}.");
  //   final List<dynamic> decoded = jsonDecode(response.body);
  //   return decoded.map((e) => WeinModel.fromJson(e)).toList();
  // }

  // Future<List<WeinbauerModel>> getWeinbauern() async {
  //   final http.Response response = await client.get(weinbauerURL);
  //   if (!response.isOk())
  //     throw new Exception(
  //         "The server returned a status code of ${response.statusCode}.");
  //   final List<dynamic> decoded = jsonDecode(response.body);
  //   return decoded.map((e) => WeinbauerModel.fromJson(e)).toList();
  // }

  // Future<List<RegionModel>> getRegionen() async {
  //   final http.Response response = await client.get(regionURL);
  //   if (!response.isOk())
  //     throw new Exception(
  //         "The server returned a status code of ${response.statusCode}.");
  //   final List<dynamic> decoded = jsonDecode(response.body);
  //   return decoded.map((e) => RegionModel.fromJson(e)).toList();
  // }

  // Future<WeinModel> postWein(WeinModel wein) async {
  //   final http.Response response = await client.post(
  //     weinURL,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(wein.toJson()),
  //   );
  //   if (!response.isOk())
  //     throw new Exception(
  //         "The server returned a status code of ${response.statusCode}.");
  //   final Map<String, dynamic> decoded = jsonDecode(response.body);
  //   final WeinModel weinModel = WeinModel.fromJson(decoded);
  //   // Das hier geht nicht so gut, da die Antwort nicht die Felder weinbauern und sorten enthält
  //   // die beste Idee ist wahrscheinlich, in dieser Methode hier dann die spezifische ID nochmals zu fetchen
  //   // und dann das zurückzuliefern, oder die API zu verändern
  //   return weinModel;
  // }
}