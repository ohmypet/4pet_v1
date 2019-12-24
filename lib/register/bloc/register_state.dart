part of petisland.register.bloc;

abstract class RegisterState extends BaseState {}

abstract class RegisterErrorState extends BaseErrorState {
  RegisterErrorState(String message) : super(message);
}

class NotLoaded extends RegisterState {}

class Loading extends RegisterState {}

class EmailSuccessful extends RegisterState {}

class CodeSuccessful extends RegisterState {}

class AccountSuccessful extends RegisterState {}

class Failed extends RegisterErrorState implements RegisterState {
  Failed(String message) : super(message);
  @override
  String toString() {
    return '$runtimeType:: error:: ${message?.toString()}';
  }
}
