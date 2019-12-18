part of petisland.register.bloc;

class RegisterBloc extends TBloc<RegisterEvent, RegisterState> {
  static final AccountService accountService =
      DI.get<AccountService>(AccountService);

  @override
  Duration get delayEvent => Duration(seconds: 0);

  @override
  Stream<RegisterState> errorToState(BaseErrorEvent event) async* {
    switch (event.runtimeType) {
      case EmailError:
        yield Failed(event.message);
        break;
    }
  }

  @override
  Stream<RegisterState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case SubmitEmail:
        yield Loading();
        _handleEmailSubmit(event);
        break;
      case EmailSuccess:
        yield Successful();
    }
  }

  @override
  RegisterState get initialState => NotLoaded();

  void submitEmail(String email) {
    this.add(SubmitEmail(email));
  }

  void _handleEmailSubmit(SubmitEmail event) {
    FutureOr<void> _handleRequireCodeSuccess(Account value) {
      add(EmailSuccess());
      //navigateToScreen Username password
    }

    FutureOr<void> _handleError(dynamic error) {
      if (error is PetApiException) {
        notifyError(EmailError(error.message));
      } else {
        notifyError(EmailError(error.toString()));
      }
    }

    if (event?.email?.trim()?.isEmpty ?? true) {
      _handleError('Email không hợp lệ');
    }
    accountService
        .requireCode(event.email)
        .then(_handleRequireCodeSuccess)
        .catchError(_handleError);
  }
}
