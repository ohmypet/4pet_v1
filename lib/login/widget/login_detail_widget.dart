part of petisland.login.widget;

class LoginDetailWidget extends TStatefulWidget {
  final LoginBloc bloc;
  final void Function(String user, String pass) onLoginTapped;

  LoginDetailWidget(this.bloc, this.onLoginTapped, {Key key}) : super(key: key);

  @override
  _LoginDetailWidgetState createState() => _LoginDetailWidgetState();
}

class _LoginDetailWidgetState extends TState<LoginDetailWidget> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  ThemeData get theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextLogo(),
            const SizedBox(height: 30),
            UserInputWidget(
              usernameController,
              focusNode: usernameFocusNode,
              hintText: TConstants.hint_username,
              icon: Icon(Icons.person, size: 22),
              onSubmit: _onUserNameSubmitted,
            ),
            UserInputWidget(
              passwordController,
              focusNode: passwordFocusNode,
              hintText: TConstants.hint_password,
              isObscureText: true,
              icon: Icon(Icons.vpn_key, size: 22),
              onSubmit: _onPasswordSubmitted,
            ),
            PetIslandButtonWidget(
              text: TConstants.text_login,
              onTap: _onTapLogin,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => navigateToScreen(
                  context: context,
                  screen: RegisterEmailScreen(),
                  screenName: RegisterEmailScreen.name,
                ),
                child: Text(
                  TConstants.text_register,
                  style: theme.textTheme.bodyText2
                      .copyWith(color: theme.accentColor),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => navigateToScreen(
                  context: context,
                  screen: ForgetPasswordScreen(),
                  screenName: RegisterEmailScreen.name,
                ),
                child: Text(
                  TConstants.text_forget_password,
                  style: theme.textTheme.bodyText2
                      .copyWith(color: theme.accentColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onUserNameSubmitted() {
    passwordFocusNode.requestFocus();
  }

  void _onPasswordSubmitted() {
    if (passwordFocusNode.hasFocus) passwordFocusNode.unfocus();
    _logging();
  }

  void _onTapLogin() {
    usernameFocusNode.unfocus();
    passwordFocusNode.unfocus();
    _logging();
  }

  void _logging() {
    final String user = usernameController.text.trim();
    final String pass = passwordController.text.trim();

    if (isValid(user) && isValid(pass)) {
      widget.onLoginTapped(user, pass);
    } else {
      if (!isValid(user)) {
        showErrorSnackBar(context: context, content: 'Username invalid');
        return;
      }

      if (!isValid(pass)) {
        showErrorSnackBar(context: context, content: 'Password invalid');
        return;
      }
    }
  }

  bool isValid(String text) => text.length > 4;

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
  }
}
