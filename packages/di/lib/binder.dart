part of lib;

abstract class Binder {
  Binder _bind(dynamic key, Object to);

  Binding bind<T>(dynamic key);

  T get<T>(dynamic key);

  factory Binder() => BinderImpl();
}

class BinderImpl implements Binder {
  final Map<dynamic, Object> _mapInstance = <dynamic, Object>{};

  @override
  Binder _bind(dynamic key, Object obj) {
    _mapInstance[key] = obj;
    return this;
  }

  @override
  Binding bind<T>(dynamic key) {
    return BindingImpl(this, key);
  }

  @override
  T get<T>(dynamic key) {
    return _mapInstance[key];
  }
}
