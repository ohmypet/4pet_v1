part of petisland.register.screen;

class RegisterAccountScreen extends TStatelessWidget {
  static String name = '/RegisterAccountScreen';
  final Duration timeAnimation = const Duration(milliseconds: 210);
  final RegisterBloc registerBloc = DI.get(RegisterBloc);

  RegisterAccountScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedPadding(
      duration: timeAnimation,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: TColors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: Center(
            child: IconButton(
              onPressed: () => _onTapBack(context),
              icon: Icon(
                Icons.arrow_back_ios,
                size: 24,
                color: theme.accentColor,
              ),
            ),
          ),
        ),
        body: Stack(
          overflow: Overflow.visible,
          fit: StackFit.expand,
          children: <Widget>[
            RegisterAccountWidget(),
            Builder(
              builder: (BuildContext context) {
                return BlocBuilder<RegisterBloc, RegisterState>(
                  bloc: registerBloc,
                  condition: (_, RegisterState state) {
                    if (state is Failed) _showError(context, state);
                    if (state is AccountSuccessful) {
                      closeUntil(context, MainAppScreen.name);
                    }
                    return true;
                  },
                  builder: (_, RegisterState state) {
                    switch (state.runtimeType) {
                      case Loading:
                        return LoadingWidget();
                        break;
                      default:
                        return SizedBox();
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _showError(BuildContext context, Failed state) {
    showErrorSnackBar(context: context, content: state.message);
  }

  void _onTapBack(BuildContext context) {
    closeScreen(context, name);
  }
}
