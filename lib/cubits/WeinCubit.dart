import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weindb/cubits/CubitBase.dart';
// import 'package:weindb/cubits/DatabaseProvider.dart';
import 'package:weindb/cubits/DatabaseProviderBase.dart';
import 'package:weindb/cubits/ElementState.dart';
import 'package:weindb/models/models.dart';

class WeinCubit extends Cubit<ElementState<WeinModel>>
    with CubitBase<WeinModel> {
  DatabaseProviderBase _db;

  WeinCubit(this._db, [ElementState<WeinModel>? initialState])
      : super(initialState ?? ElementState<WeinModel>(isInitializing: true)) {
    initialize();
  }

  @override
  Future<void> change(WeinModel item) async {
    var data = state.data;
    var index = data.indexWhere((element) => element.id == item.id);
    var oldData = data[index];
    assert(data[index] != item);
    data[index] = item;
    emit(state.copyWith(data: data));
    try {
      await _db.patchWein(item);
    } catch (error) {
      data[index] = oldData;
      emit(state.copyWith(data: data));
      throw error;
    }
  }

  @override
  Future<WeinModel> create(WeinModel item) async {
    List<WeinModel> data = state.data;
    assert(!data.contains(item));
    data.add(item);
    emit(state.copyWith(data: data));
    late int id;
    try {
      id = await _db.postWein(item);
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
    emit(ElementState<WeinModel>(isInitializing: true));
    await reload();
    completedInitialization();
  }

  @override
  Future<void> reload() async {
    emit(state.copyWith(isLoading: true));
    try {
      List<WeinModel> weine = await _db.getWeine();
      emit(ElementState<WeinModel>(
          isLoading: false, data: weine, isInitializing: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isError: true));
    }
  }

  @override
  Future<void> remove(WeinModel item) async {
    var data = state.data;
    data.remove(item);
    emit(state.copyWith(data: data));
    try {
      await _db.deleteWein(item);
    } catch (error) {
      data.add(item);
      emit(state.copyWith(data: data));
      throw error;
    }
  }
}