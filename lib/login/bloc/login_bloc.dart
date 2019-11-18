part of petisland.login.bloc;

class LoginBloc extends TBloc<LoginEvent, LoginState> {
  final AccountService accountService = DI.get(AccountService);

  @override
  LoginState get initialState => null;

  @override
  final Duration delayEvent = const Duration(milliseconds: 50);

  void _logging(LoginEvent event) {}

  @override
  Stream<LoginState> errorToState(BaseErrorEvent event) async* {}

  @override
  Stream<LoginState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case LoggingEvent:
        yield LoggingState();
        _logging(event);
        break;
      default:
    }
  }
}
