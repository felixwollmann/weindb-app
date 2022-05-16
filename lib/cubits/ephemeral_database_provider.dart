import 'package:weindb/cubits/DatabaseProviderBase.dart';
import 'package:weindb/models/models.dart';

import '../tools/generator.dart';


/// Mock Database Provider which just stores everything in memory
class EphemeralDatabaseProvider extends DatabaseProviderBase {
  List<WeinModel> weinModels = [];
  List<WeinbauerModel> weinbauerModels = [];
  List<RegionModel> regionModels = [];
  List<SorteModel> sorteModels = [];

  /// Populate the database with **generated fake entries**
  void populate([int amount = 10, int? seed]) {
    Generator gen = Generator(seed);
    weinModels = List.generate(amount, (index) => gen.randomWein());
    weinbauerModels = List.generate(amount, (index) => gen.randomWeinbauer());
    sorteModels = List.generate(amount, (index) => gen.randomSorte());
    regionModels = List.generate(amount, (index) => gen.randomRegion());
  }

  @override
  Future<void> deleteRegion(RegionModel region) async {
    regionModels.remove(region);
  }

  @override
  Future<void> deleteSorte(SorteModel sorte) async {
    sorteModels.remove(sorte);
  }

  @override
  Future<void> deleteWein(WeinModel wein) async {
    weinModels.remove(wein);
  }

  @override
  Future<void> deleteWeinbauer(WeinbauerModel weinbauer) async {
    weinbauerModels.remove(weinbauer);
  }

  // to emulate the real database, we can't simply return the list,
  // we need to make a copy

  @override
  Future<List<RegionModel>> getRegionen() async {
    return List.of(regionModels);
  }

  @override
  Future<List<SorteModel>> getSorten() async {
    return List.of(sorteModels);
  }

  @override
  Future<List<WeinbauerModel>> getWeinbauern() async {
    return List.of(weinbauerModels);
  }

  @override
  Future<List<WeinModel>> getWeine() async {
    return List.of(weinModels);
  }

  @override
  Future<void> patchRegion(RegionModel region) async {
    regionModels[
        regionModels.indexWhere((element) => element.id == region.id)] = region;
  }

  @override
  Future<void> patchSorte(SorteModel sorte) async {
    sorteModels[sorteModels.indexWhere((element) => element.id == sorte.id)] =
        sorte;
  }

  @override
  Future<void> patchWein(WeinModel wein) async {
    weinModels[weinModels.indexWhere((element) => element.id == wein.id)] =
        wein;
  }

  @override
  Future<void> patchWeinbauer(WeinbauerModel weinbauer) async {
    weinbauerModels[weinbauerModels
        .indexWhere((element) => element.id == weinbauer.id)] = weinbauer;
  }

  @override
  Future<int> postRegion(RegionModel region) async {
    var index = regionModels.length;
    regionModels.add(region.copyWith(id: index));
    return index;
  }

  @override
  Future<int> postSorte(SorteModel sorte) async {
    var index = sorteModels.length;
    sorteModels.add(sorte.copyWith(id: index));
    return index;
  }

  @override
  Future<int> postWein(WeinModel wein) async {
    var index = weinModels.length;
    weinModels.add(wein.copyWith(id: index));
    return index;
  }

  @override
  Future<int> postWeinbauer(WeinbauerModel weinbauer) async {
    var index = weinbauerModels.length;
    weinbauerModels.add(weinbauer.copyWith(id: index));
    return index;
  }
}
