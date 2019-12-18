part of petisland.authentication;

abstract class AuthenticationEvent extends BaseEvent {
  @override
  String toString() => '$runtimeType';
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final LoginData dataLogin;

  LoggedIn(this.dataLogin);

  @override
  String toString() => 'LoggedIn ${dataLogin.account?.username}';
}

class LoggedOut extends AuthenticationEvent {}
