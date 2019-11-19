part of petisland.authentication;

abstract class AuthenticationEvent extends BaseEvent {
  @override
  String toString() => "$runtimeType";
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}
