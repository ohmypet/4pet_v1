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

class EmailSuccess extends RegisterEvent {}

class EmailError extends RegisterErrorEvent implements RegisterEvent{
  EmailError(String message) : super(message);
}
