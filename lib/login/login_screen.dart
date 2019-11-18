part of petisland.login;

class LoginScreen extends TStatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends TState<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final Duration timeAnimation = const Duration(milliseconds: 210);
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: timeAnimation,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Flex(
              direction: Axis.vertical,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                UserInputWidget(
                  usernameController,
                  focusNode: usernameFocusNode,
                  hintText: TConstant.hint_username,
                  icon: Icon(Icons.person, size: 22),
                  onSubmit: _onUserNameSubmitted,
                ),
                UserInputWidget(
                  passwordController,
                  focusNode: passwordFocusNode,
                  hintText: TConstant.hint_password,
                  isObscureText: true,
                  icon: Icon(Icons.vpn_key, size: 22),
                  onSubmit: _onPasswordSubmitted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onUserNameSubmitted() {
    passwordFocusNode.requestFocus();
  }

  void _onPasswordSubmitted() {
    if (passwordFocusNode.hasFocus) passwordFocusNode.unfocus();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }
}
