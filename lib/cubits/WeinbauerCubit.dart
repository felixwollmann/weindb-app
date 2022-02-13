import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weindb/cubits/CubitBase.dart';
// import 'package:weindb/cubits/DatabaseProvider.dart';
import 'package:weindb/cubits/DatabaseProviderBase.dart';
import 'package:weindb/cubits/ElementState.dart';
import 'package:weindb/models/models.dart';

class WeinbauerCubit extends Cubit<ElementState<WeinbauerModel>>
    with CubitBase<WeinbauerModel> {
  DatabaseProviderBase _db;

  WeinbauerCubit(this._db, [ElementState<WeinbauerModel>? initialState])
      : super(initialState ?? ElementState<WeinbauerModel>(isInitializing: true)) {
    initialize();
  }

  @override
  Future<void> change(WeinbauerModel item) async {
    var data = state.data;
    var index = data.indexWhere((element) => element.id == item.id);
    var oldData = data[index];
    assert(data[index] != item);
    data[index] = item;
    emit(state.copyWith(data: data));
    try {
      await _db.patchWeinbauer(item);
    } catch (error) {
      data[index] = oldData;
      emit(state.copyWith(data: data));
      throw error;
    }
  }

  @override
  Future<WeinbauerModel> create(WeinbauerModel item) async {
    List<WeinbauerModel> data = state.data;
    assert(!data.contains(item));
    data.add(item);
    emit(state.copyWith(data: data));
    late int id;
    try {
      id = await _db.postWeinbauer(item);
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
    emit(ElementState<WeinbauerModel>(isInitializing: true));
    await reload();
    completedInitialization();
  }

  @override
  Future<void> reload() async {
    emit(state.copyWith(isLoading: true));
    try {
      List<WeinbauerModel> weinbauern = await _db.getWeinbauern();
      emit(ElementState<WeinbauerModel>(
          isLoading: false, data: weinbauern, isInitializing: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isError: true));
    }
  }

  @override
  Future<void> remove(WeinbauerModel item) async {
    var data = state.data;
    data.remove(item);
    emit(state.copyWith(data: data));
    try {
      await _db.deleteWeinbauer(item);
    } catch (error) {
      data.add(item);
      emit(state.copyWith(data: data));
      throw error;
    }
  }
}