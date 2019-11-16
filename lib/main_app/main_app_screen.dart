part of petisland.main_app;

class MainAppScreen extends TStatelessWidget {
  static String name = "/";
  final MainAppBloc bloc;
  const MainAppScreen(this.bloc, {Key key}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: FlatButton(
            child: Text("Change Theme"),
            onPressed: _changeColor,
          ),
        ),
      ),
    );
  }

  void _changeColor() {
    bloc.add(ThemeAppChangedEvent());
  }
}
