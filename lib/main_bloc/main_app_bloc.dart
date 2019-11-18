part of petisland.main_bloc;

///------------------------------------------------
/// Define bloc
///------------------------------------------------

class MainAppBloc extends TBloc<MainAppEvent, MainAppState> {
  // PetIslandTheme theme = PetIslandLightTheme();
  ThemeMode themeMode = ThemeMode.light;

  final PetIslandTheme lightTheme = PetIslandLightTheme();
  final PetIslandTheme dartTheme = PetIslandDarkTheme();

  @override
  MainAppState get initialState => CreatedAppState();

  @override
  final Duration delayEvent = const Duration(milliseconds: 50);

  @override
  Stream<MainAppState> errorToState(BaseErrorEvent event) {
    return null;
  }

  @override
  Stream<MainAppState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case DependenceLoadingEvent:
        yield DependenceLoadingApp();
        break;

      case ThemeAppChangedEvent:
        themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
        yield ThemeAppChanged();
        break;

      case DependenceLoadedEvent:
        yield ActiveApp();
        break;
      default:
    }
  }
}
