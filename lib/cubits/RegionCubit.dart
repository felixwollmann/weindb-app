import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weindb/cubits/CubitBase.dart';
// import 'package:weindb/cubits/DatabaseProvider.dart';
import 'package:weindb/cubits/DatabaseProviderBase.dart';
import 'package:weindb/cubits/ElementState.dart';
import 'package:weindb/models/models.dart';

class RegionCubit extends Cubit<ElementState<RegionModel>>
    with CubitBase<RegionModel> {
  DatabaseProviderBase _db;

  RegionCubit(this._db, [ElementState<RegionModel>? initialState])
      : super(initialState ?? ElementState<RegionModel>(isInitializing: true)) {
    initialize();
  }

  @override
  Future<void> change(RegionModel item) async {
    var data = state.data;
    var index = data.indexWhere((element) => element.id == item.id);
    var oldData = data[index];
    assert(data[index] != item);
    data[index] = item;
    emit(state.copyWith(data: data));
    try {
      await _db.patchRegion(item);
    } catch (error) {
      data[index] = oldData;
      emit(state.copyWith(data: data));
      throw error;
    }
  }

  @override
  Future<RegionModel> create(RegionModel item) async {
    List<RegionModel> data = state.data;
    assert(!data.contains(item));
    data.add(item);
    emit(state.copyWith(data: data));
    late int id;
    try {
      id = await _db.postRegion(item);
    } catch (error) {
      data.remove(item);
      emit(state.copyWith(data: data));
      throw error;
    }
    data.remove(item);
    var newItem = item.copyWith(id: id);
    data.add(newItem);
    emit(state.copyWith(data: data));
    return newItem;
  }

  @override
  void initialize() async {
    emit(ElementState<RegionModel>(isInitializing: true));
    await reload();
    completedInitialization();
  }

  @override
  Future<void> reload() async {
    emit(state.copyWith(isLoading: true));
    try {
      List<RegionModel> regionen = await _db.getRegionen();
      emit(ElementState<RegionModel>(
          isLoading: false, data: regionen, isInitializing: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isError: true));
    }
  }

  @override
  Future<void> remove(RegionModel item) async {
    var data = state.data;
    data.remove(item);
    emit(state.copyWith(data: data));
    try {
      await _db.deleteRegion(item);
    } catch (error) {
      data.add(item);
      emit(state.copyWith(data: data));
      throw error;
    }
  }
}