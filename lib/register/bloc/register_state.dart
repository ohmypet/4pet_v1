part of petisland.register.bloc;

abstract class RegisterState extends BaseState {}

abstract class RegisterErrorState extends BaseErrorState {
  RegisterErrorState(String message) : super(message);
}

class NotLoaded extends RegisterState {}

class Loading extends RegisterState {}

class Successful extends RegisterState {}

class Failed extends RegisterErrorState implements RegisterState{
  Failed(String message) : super(message);
  @override
  String toString() {
    return '$runtimeType:: error:: ${message?.toString()}';
  }
}
