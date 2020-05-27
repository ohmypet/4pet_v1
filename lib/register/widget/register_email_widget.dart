part of petisland.register.widget;

class RegisterEmailWidget extends TStatefulWidget {
  RegisterEmailWidget({Key key}) : super(key: key);

  @override
  _LoginDetailWidgetState createState() => _LoginDetailWidgetState();
}

class _LoginDetailWidgetState extends TState<RegisterEmailWidget> {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final regex = RegExp(pattern);
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final RegisterBloc registerBloc = DI.get(RegisterBloc);

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
            UserInputWidget(
              emailController,
              focusNode: emailFocusNode,
              hintText: 'your-mail@4pet.socail',
              icon: Icon(Icons.person, size: 22),
              onSubmit: _onEmailSubmitted,
              onChange: _onTextChanged,
            ),
            Opacity(
              opacity: isValid ? 1 : 0.2,
              child: PetIslandButtonWidget(
                text: 'Next',
                onTap: isValid ? _onEmailSubmitted : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onEmailSubmitted() {
    registerBloc.submitEmail(emailController.text ?? '');
  }

  bool get isValid => regex.hasMatch(emailController.text);

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
  }

  void _onTextChanged(String str) {
    setState(() {});
  }
}
