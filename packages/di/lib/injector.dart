part of lib;

class Injector {
  Binder _binder;

  Injector(Binder binder) {
    this._binder = binder;
  }
  T get<T>(dynamic key) {
    return _binder.get<T>(key);
  }

  static InjectorBuilder builder() => InjectorBuilder();
}

class InjectorBuilder {
  Binder _binder;
  final List<Module> _modules = <Module>[];

  InjectorBuilder withBinder([Binder binder]) {
    _binder = binder ?? BinderImpl();
    return this;
  }

  InjectorBuilder withModule(Module module) {
    _modules.add(module);
    return this;
  }

  InjectorBuilder withModules(List<Module> modules) {
    _modules.addAll(modules);
    return this;
  }

  Injector build() {
    _modules.forEach((Module module) => module.configure(_binder));

    return Injector(_binder);
  }

  Future<Injector> buildAsync() async {
    for (Module module in _modules) {
      await module.configureAsync(_binder);
    }

    return Injector(_binder);
  }
}
