part of petisland.register.screen;

class RegisterCodeScreen extends TStatelessWidget {
  static String name = '/RegisterCodeScreen';
  final Duration timeAnimation = const Duration(milliseconds: 210);
  final RegisterBloc registerBloc = DI.get(RegisterBloc);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  RegisterCodeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedPadding(
      duration: timeAnimation,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Stack(
        children: <Widget>[
          Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: TColors.white,
              elevation: 2,
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
              title: Text(
                'Nhập mã xác nhận',
                style: TTextStyles.bold(fontSize: 18),
              ),
              centerTitle: true,
            ),
            body: RegisterCodeWidget(),
          ),
          Builder(
            builder: (BuildContext context) {
              return BlocBuilder<RegisterBloc, RegisterState>(
                bloc: registerBloc,
                condition: (_, RegisterState state) {
                  if (state is Failed) _showError(context, state);
                  if (state is CodeSuccessful) {
                    navigateToScreen(
                        context: context,
                        screen: RegisterAccountScreen(),
                        screenName: RegisterAccountScreen.name);
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
