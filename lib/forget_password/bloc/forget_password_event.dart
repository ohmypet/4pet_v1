part of 'forget_password_bloc.dart';

@immutable
abstract class ForgetPasswordEvent {
  @override
  String toString() {
    return '$runtimeType';
  }
}

class TypingEmail extends ForgetPasswordEvent {
  final String email;

  TypingEmail(this.email);
}

class TypingCode extends ForgetPasswordEvent {
  final String code;

  TypingCode(this.code);
}

class TypingNewPassword extends ForgetPasswordEvent {
  final String password;

  TypingNewPassword(this.password);
}

class TypingRePassword extends ForgetPasswordEvent {
  final String rePassword;

  TypingRePassword(this.rePassword);
}

class SubmitEmail extends ForgetPasswordEvent {}


class SubmitCode extends ForgetPasswordEvent {}


class SubmitNewPassword extends ForgetPasswordEvent{}


