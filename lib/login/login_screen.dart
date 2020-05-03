part of petisland.login;

class LoginScreen extends TStatelessWidget {
  final Duration timeAnimation = const Duration(milliseconds: 210);

  final LoginBloc loginBloc = DI.get(LoginBloc);
  final AuthenticationBloc bloc;

  LoginScreen(this.bloc, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: timeAnimation,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            LoginDetailWidget(loginBloc, _onLoginTapped),
            Builder(
              builder: (BuildContext context) {
                return BlocBuilder<LoginBloc, LoginState>(
                  bloc: loginBloc,
                  condition: (_, LoginState state) {
                    if (state is LoginError) _showError(context, state);
                    if (state is LoginSucceed) _navigateToHomePage();
                    return true;
                  },
                  builder: (_, LoginState state) {
                    return state is LoggingState
                        ? const LoadingWidget()
                        : SizedBox();
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _onLoginTapped(String user, String pass) {
    loginBloc.login(user, pass);
  }

  void _showError(BuildContext context, LoginError state) {
    showErrorSnackBar(content: state.message, context: context);
  }

  void _navigateToHomePage() {
    bloc.reload();
  }
}
