part of lib;

abstract class Module {
  void configure(Binder binder);
  void configureAsync(Binder binder);
}

abstract class AbstractModule implements Module {
  Binder _binder;
  Binder binder() {
    return _binder;
  }

  void init();

  @override
  void configure(Binder binder) {
    _binder = binder;
    init();
  }

  @override
  Future<void> configureAsync(Binder binder) async {
    _binder = binder;
    await init();
  }

  Binding bind(dynamic key) {
    return binder().bind(key);
  }

  T get<T>(dynamic key) {
    return binder().get<T>(key);
  }
}
