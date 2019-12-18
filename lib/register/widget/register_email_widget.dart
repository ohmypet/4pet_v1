part of petisland.register.widget;

class RegisterEmailWidget extends TStatefulWidget {
  RegisterEmailWidget({Key key}) : super(key: key);
  @override
  _LoginDetailWidgetState createState() => _LoginDetailWidgetState();
}

class _LoginDetailWidgetState extends TState<RegisterEmailWidget> {
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
              hintText: 'Nhập email...',
              icon: Icon(Icons.person, size: 22),
              onSubmit: _onEmailSubmitted,
            ),
            PetIslandButtonWidget(
              text: 'Tiếp',
              onTap: _onEmailSubmitted,
            ),
          ],
        ),
      ),
    );
  }

  void _onEmailSubmitted() {
    registerBloc.submitEmail(emailController.text ?? "");
  }

  bool isValid(String text) => text.length > 4;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
  }
}
