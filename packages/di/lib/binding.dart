part of lib;

abstract class Binding {
  Binder to(Object to);
}

class BindingImpl implements Binding {
  Binder _binder;
  dynamic _key;
  BindingImpl(this._binder, this._key);

  @override
  Binder to(Object to) {
    return _binder._bind(_key, to);
  }
}
