part of petisland.main_app;

class MainAppScreen extends TStatefulWidget {
  static String name = "/";
  final MainAppBloc bloc;
  const MainAppScreen(this.bloc, {Key key}) : super(key: key);

  @override
  TState<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends TState<MainAppScreen> {
  MainAppBloc get bloc => widget.bloc;
  final AuthenticationBloc authBloc = DI.get<AuthenticationBloc>(AuthenticationBloc);

  void initState() {
    super.initState();
    if (!authBloc.isInit) {
      authBloc
        ..init()
        ..add(AppStarted());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: bloc.lightTheme.getTheme(),
      darkTheme: bloc.dartTheme.getTheme(),
      themeMode: bloc.themeMode,
      navigatorObservers: <NavigatorObserver>[TNavigatorObserver()],
      routes: <String, WidgetBuilder>{
        MainAppScreen.name: (_) => _buildMainApp(),
      },
    );
  }

  Widget _buildMainApp() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: authBloc,
      builder: (_, AuthenticationState state) {
        switch (state.runtimeType) {
          case AuthenticationUninitialized:
          case UnAuthenticating:
            return const SplashScreen();
            break;
          case Unauthenticated:
            return LoginScreen();

          default:
            return Scaffold(
              appBar: AppBar(),
              body: Container(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FlatButton(
                        child: Text("Change Theme"),
                        onPressed: _changeColor,
                      ),
                    ],
                  ),
                ),
              ),
            );
        }
      },
    );
  }

  void _changeColor() {
    bloc.add(ThemeAppChangedEvent());
  }
}
