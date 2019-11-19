part of petisland.main_bloc;

///------------------------------------------------
/// State for main app
///------------------------------------------------
abstract class MainAppState extends BaseState {
  @override
  String toString() => '$runtimeType';
}

class CreatedAppState extends MainAppState {}

class DependenceLoadingApp extends MainAppState {}

class ThemeAppChanged extends MainAppState {}

class ActiveApp extends MainAppState {}

class MainAppError extends BaseErrorState implements MainAppState {
  MainAppError([String message]) : super(message);
}
