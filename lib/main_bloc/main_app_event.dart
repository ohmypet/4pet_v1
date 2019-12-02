part of petisland.main_bloc;

///------------------------------------------------
/// `Event` for main app
///------------------------------------------------
abstract class MainAppEvent extends BaseEvent {
  @override
  String toString() => '$runtimeType';
}

class DependenceLoadingEvent extends MainAppEvent {}

class DependenceLoadedEvent extends MainAppEvent {}

class ThemeAppChangedEvent extends MainAppEvent {}
