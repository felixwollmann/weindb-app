import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weindb/cubits/CubitBase.dart';
// import 'package:weindb/cubits/DatabaseProvider.dart';
import 'package:weindb/cubits/DatabaseProviderBase.dart';
import 'package:weindb/cubits/ElementState.dart';
import 'package:weindb/models/models.dart';

class SorteCubit extends Cubit<ElementState<SorteModel>>
    with CubitBase<SorteModel> {
  DatabaseProviderBase _db;

  SorteCubit(this._db, [ElementState<SorteModel>? initialState])
      : super(initialState ?? ElementState<SorteModel>(isInitializing: true)) {
    initialize();
  }

  @override
  Future<void> change(SorteModel item) async {
    var data = state.data;
    var index = data.indexWhere((element) => element.id == item.id);
    var oldData = data[index];
    assert(data[index] != item);
    data[index] = item;
    emit(state.copyWith(data: data));
    try {
      await _db.patchSorte(item);
    } catch (error) {
      data[index] = oldData;
      emit(state.copyWith(data: data));
      throw error;
    }
  }

  @override
  Future<SorteModel> create(SorteModel item) async {
    List<SorteModel> data = state.data;
    assert(!data.contains(item));
    data.add(item);
    emit(state.copyWith(data: data));
    late int id;
    try {
      id = await _db.postSorte(item);
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
    emit(ElementState<SorteModel>(isInitializing: true));
    await reload();
    completedInitialization();
  }

  @override
  Future<void> reload() async {
    emit(state.copyWith(isLoading: true));
    try {
      List<SorteModel> sorten = await _db.getSorten();
      emit(ElementState<SorteModel>(
          isLoading: false, data: sorten, isInitializing: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isError: true));
    }
  }

  @override
  Future<void> remove(SorteModel item) async {
    var data = state.data;
    data.remove(item);
    emit(state.copyWith(data: data));
    try {
      await _db.deleteSorte(item);
    } catch (error) {
      data.add(item);
      emit(state.copyWith(data: data));
      throw error;
    }
  }
}