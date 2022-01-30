abstract class CubitBase<T> {
  void initialize();
  Future<void> reload();
  Future<void> remove(T item);
  Future<T> create(T item);
  Future<void> change(T item);
}