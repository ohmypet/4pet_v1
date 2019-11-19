part of petisland.home_page;

class HomePageScreen extends TStatelessWidget {
  final AuthenticationBloc bloc;
  HomePageScreen(this.bloc, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: GestureDetector(
            onTap: _onTap,
            child: Text("Logout"),
          ),
        ),
      ),
    );
  }

  void _onTap() {
    bloc.logout();
  }
}
