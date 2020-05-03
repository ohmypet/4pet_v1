part of petisland.register.bloc;

abstract class RegisterEvent extends BaseEvent {}

abstract class RegisterErrorEvent extends BaseErrorEvent {
  RegisterErrorEvent(String message) : super(message);
}

class SubmitEmail extends RegisterEvent {
  final String email;

  SubmitEmail(this.email);

  @override
  String toString() {
    return '$runtimeType:: email:: $email';
  }
}

class SubmitCode extends RegisterEvent {
  final String requireCode;

  SubmitCode(this.requireCode);

  @override
  String toString() {
    return '$runtimeType:: requireCode:: $requireCode';
  }
}

class SubmitAccount extends RegisterEvent {
  final String userName;
  final String password;
  final User user;

  SubmitAccount(this.userName, this.password, {this.user});

  @override
  String toString() {
    return '$runtimeType:: {userName:: $userName, password:: $password, user:: $user}';
  }
}

class EmailSuccess extends RegisterEvent {}

class CodeSuccess extends RegisterEvent {}

class AccountSuccess extends RegisterEvent {}

class EmailError extends RegisterErrorEvent implements RegisterEvent {
  EmailError(String message) : super(message);
}

class CodeError extends RegisterErrorEvent implements RegisterEvent {
  CodeError(String message) : super(message);
}

class AccountError extends RegisterErrorEvent implements RegisterEvent {
  AccountError(String message) : super(message);
}
