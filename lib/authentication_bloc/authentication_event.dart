part of petisland.authentication;

abstract class AuthenticationEvent {
  @override
  String toString() => "$runtimeType";
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}
