part of petisland.register.widget;

class RegisterCodeWidget extends TStatefulWidget {
  RegisterCodeWidget({Key key}) : super(key: key);

  @override
  _RegisterCodeWidgetState createState() => _RegisterCodeWidgetState();
}

class _RegisterCodeWidgetState extends TState<RegisterCodeWidget> {
  final TextEditingController codeController = TextEditingController();
  final FocusNode codeFocusNode = FocusNode();
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
              codeController,
              focusNode: codeFocusNode,
              hintText: 'Confirm code',
              keyboardType: TextInputType.number,
              textAlign: TextAlign.left,
              icon: Icon(Icons.code, size: 22),
              onSubmit: _onCodeSubmitted,
              onChange: _onTextChanged,
            ),
            Opacity(
              opacity: isValid(codeController.text.length) ? 1 : 0.2,
              child: PetIslandButtonWidget(
                text: 'Next',
                onTap: isValid(codeController.text.length)
                    ? _onCodeSubmitted
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCodeSubmitted() {
    registerBloc.submitCode(codeController.text ?? '');
  }

  bool isValid(int textLength) => textLength == 4;

  @override
  void dispose() {
    super.dispose();
    codeController.dispose();
    codeFocusNode.dispose();
  }

  void _onTextChanged(String str) {
    if (isValid(str.length)) {
      _onCodeSubmitted();
    }
    setState(() {});
  }
}
