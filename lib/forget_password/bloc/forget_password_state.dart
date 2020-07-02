part of 'forget_password_bloc.dart';

@immutable
abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class StepOneState extends ForgetPasswordState {}

class ErrorStepOneState extends StepOneState {
  final String message;

  ErrorStepOneState(this.message);
}

class StepTwoState extends ForgetPasswordState {}

class ErrorStepTwoState extends StepTwoState {
  final List<String> error;

  ErrorStepTwoState(this.error);
}

class StepThreeState extends ForgetPasswordState {}

class ErrorStepThreeState extends StepThreeState {
  final List<MapEntry<String, String>> errors;

  ErrorStepThreeState(this.errors);
}

class Loading extends ForgetPasswordState {}

class SuccessForgetPasswordState extends ForgetPasswordState{
  final Account account;

  SuccessForgetPasswordState(this.account);
}

class Error extends ForgetPasswordState {
  final String message;

  Error(this.message);
}
