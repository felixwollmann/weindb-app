import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class CubitBase<T> {
  void initialize();
  Future<void> reload();
  Future<void> remove(T item);
  Future<T> create(T item);

  /// Change the element [item], from its old state, to its new state.
  /// 
  /// The old state is identified by its id.
  /// 
  /// Returns a future with completes fine, when the element could be correctly edited & saved to the database.
  /// Return a future with an error, when an error occured (network, database, ...).
  Future<void> change(T item);

  /// Should be called when [this] is initialized - when it fetched the necessary data from the database.
  @protected
  void completedInitialization() {
    if (_initializeCompleter.isCompleted) {
      return;
    }
    _initializeCompleter.complete();
  }

  /// the completer used to signal that the initialization is complete.
  /// 
  /// A Completer can be used to create a Future, which can be controlled via Methods, like in this example
  Completer<void> _initializeCompleter = Completer<void>();



  /// Future which will complete when the cubit is initialized
  /// 
  /// ```dart
  /// WeinCubit cubit = WeinCubit(db);
  /// await cubit.awaitInitialization();
  /// // the cubit is now initialized - it fetched the data from the database
  /// ```
  Future<void> get awaitInitialization => _initializeCompleter.future;
}