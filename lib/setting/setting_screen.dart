part of petisland.setting;

class SettingScreen extends StatelessWidget {
  final AuthenticationBloc bloc;

  const SettingScreen({
    @required this.bloc,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin cá nhân"),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          child: Text("Logout"),
          onTap: _onTap,
        ),
      ),
    );
  }

  void _onTap() {
    bloc.logout();
  }
}
