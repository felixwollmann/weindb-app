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
}