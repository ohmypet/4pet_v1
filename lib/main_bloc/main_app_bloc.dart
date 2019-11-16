part of petisland.main_bloc;

///------------------------------------------------
/// Define bloc
///------------------------------------------------

class MainAppBloc extends Bloc<MainAppEvent, MainAppState> {
  // PetIslandTheme theme = PetIslandLightTheme();
  ThemeMode themeMode = ThemeMode.light;

  final PetIslandTheme lightTheme = PetIslandLightTheme();
  final PetIslandTheme dartTheme = PetIslandDarkTheme();

  @override
  MainAppState get initialState => CreatedAppState();

  @override
  Stream<MainAppState> mapEventToState(MainAppEvent event) async* {
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
