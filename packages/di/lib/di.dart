library lib;

part 'injector.dart';
part 'module.dart';
part 'binder.dart';
part 'binding.dart';

/// A facade class to work with your DI
abstract class DI {
  static Injector _injector;

  /// Init Injector with your Module
  static void init(List<Module> modules) {
    _injector = Injector.builder().withBinder().withModules(modules).build();
  }

  static Future<void> initAsync(List<Module> modules) async {
    _injector =
        await Injector.builder().withBinder().withModules(modules).buildAsync();
  }

  static T get<T>(dynamic key) {
    return _injector.get<T>(key);
  }
}
