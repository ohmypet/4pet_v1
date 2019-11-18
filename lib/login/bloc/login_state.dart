part of petisland.login.bloc;

abstract class LoginState extends BaseState {
  @override
  String toString() => "$runtimeType";
}

class InitLoginState extends LoginState {}

class LoggingState extends LoginState {}

class LoginFailed extends LoginState {}

class LoginSucceed extends LoginState {}
