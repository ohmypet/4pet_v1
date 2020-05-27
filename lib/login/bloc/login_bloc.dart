part of petisland.login.bloc;

class LoginBloc extends TBloc<LoginEvent, LoginState> {
  @protected
  static final AccountService accountService =
      DI.get<AccountService>(AccountService);

  @protected
  static final LocalStorageService storageService = DI.get(LocalStorageService);

  @override
  LoginState get initialState => InitLoginState();

  @override
  final Duration delayEvent = const Duration(milliseconds: 50);

  @override
  Stream<LoginState> errorToState(BaseErrorEvent event) async* {
    yield LoginError(event.message);
  }

  @override
  Stream<LoginState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case LoggingEvent:
        yield LoggingState();
        _logging(event);
        break;
      case LoginSucceedEvent:
        yield LoginSucceed();
        break;
      default:
    }
  }

  void _logging(LoggingEvent event) {
    accountService
        .login(event.username, event.password)
        .then(_handleLoginSuccess)
        .catchError(_handleError);
  }

  void login(String username, String password) {
    final LoginEvent event = LoggingEvent(username, password);
    add(event);
  }

  FutureOr<void> _handleLoginSuccess(LoginData value) {
    storageService.updateToken(value.token);
    add(LoginSucceedEvent());
  }

  FutureOr<void> _handleError(dynamic error) {
    notifyError(LoginErrorEvent('Username or password invalid'));
  }
}
