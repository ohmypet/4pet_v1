part of petisland.authentication;

abstract class AuthenticationState extends BaseState {
  @override
  String toString() => "$runtimeType";
}

/// App init
class AuthenticationUninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {}

/// App no auth
class Unauthenticated extends AuthenticationState {}

/// App logout
class UnAuthenticating extends AuthenticationState {}

class AuthenticatingError extends BaseErrorState implements AuthenticationState {
  AuthenticatingError([String message]) : super(message);
}
