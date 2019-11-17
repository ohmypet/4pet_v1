part of petisland.login;

class LoginScreen extends TStatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends TState<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomTextField(
                usernameController,
                hintText: "Username",
                icon: Icon(Icons.person, size: 22),
              ),
              CustomTextField(
                passwordController,
                hintText: "Password",
                isObscureText: true,
                icon: Icon(Icons.vpn_key, size: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends TStatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscureText;
  final Widget icon;
  final TextInputType keyboardType;

  CustomTextField(
    this.controller, {
    Key key,
    this.hintText,
    this.isObscureText = false,
    this.icon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 1),
      child: TextField(
        controller: controller,
        style: themeData.textTheme.body1,
        maxLines: 1,
        keyboardType: keyboardType,
        autocorrect: false,
        cursorColor: themeData.primaryColor,
        textInputAction: TextInputAction.next,
        obscureText: isObscureText,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: icon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }
}
