part of petisland.login;

class LoginScreen extends TStatelessWidget {
  final Duration timeAnimation = const Duration(milliseconds: 210);

  final LoginBloc loginBloc = DI.get(LoginBloc);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: timeAnimation,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LoginDetailWidget(loginBloc, _onLoginTapped),
      ),
    );
  }

  void _onLoginTapped(String user, String pass) {
    Log.debug("$runtimeType $user $pass");
    loginBloc.login(user, pass);
  }
}
