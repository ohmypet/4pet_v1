part of petisland.register.screen;

class RegisterEmailScreen extends TStatelessWidget {
  static String name = '/RegisterEmailScreen';
  final Duration timeAnimation = const Duration(milliseconds: 210);
  final RegisterBloc registerBloc = DI.get(RegisterBloc);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  RegisterEmailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: timeAnimation,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(
        children: <Widget>[
          Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 1,
              automaticallyImplyLeading: false,
              leading: Center(
                child: IconButton(
                  onPressed: () => _onTapBack(context),
                  icon: Icon(Icons.arrow_back_ios, size: 24, color: TColors.white),
                ),
              ),
              title: Text(
                'Register Account',
                style: TTextStyles.bold(
                  fontSize: 18,
                  color: TColors.white,
                ),
              ),
              centerTitle: true,
            ),
            body: RegisterEmailWidget(),
          ),
          Builder(
            builder: (BuildContext context) {
              return BlocBuilder<RegisterBloc, RegisterState>(
                bloc: registerBloc,
                condition: (_, RegisterState state) {
                  if (state is Failed) _showError(context, state);
                  if (state is EmailSuccessful) {
                    navigateToScreen(
                        context: context,
                        screen: RegisterCodeScreen(),
                        screenName: RegisterCodeScreen.name);
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
    );
  }

  void _showError(BuildContext context, Failed state) {
    showSnackBarByScaffoldKey(key: scaffoldKey, content: state.message);
  }

  void _onTapBack(BuildContext context) {
    closeScreen(context, name);
  }
}
