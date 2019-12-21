part of petisland.register.bloc;

class RegisterBloc extends TBloc<RegisterEvent, RegisterState> {
  static final AccountService accountService =
      DI.get<AccountService>(AccountService);
  Account _account;

  @override
  Duration get delayEvent => Duration(seconds: 0);

  @override
  Stream<RegisterState> errorToState(BaseErrorEvent event) async* {
    switch (event.runtimeType) {
      case EmailError:
        yield Failed(event.message);
        break;
      case CodeError:
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
      case SubmitCode:
        _handleCodeSubmit(event);
        break;
      case EmailSuccess:
        yield EmailSuccessful();
        break;
      case CodeSuccess:
        yield CodeSuccessful();
        break;
    }
  }

  @override
  RegisterState get initialState => NotLoaded();

  void submitEmail(String email) {
    this.add(SubmitEmail(email));
  }

  void submitCode(String code) {
    this.add(SubmitCode(code));
  }

  void _handleEmailSubmit(SubmitEmail event) {
    FutureOr<void> _handleRequireCodeSuccess(Account value) {
      _account = value;
      add(EmailSuccess());
    }

    FutureOr<void> _handleError(dynamic error) {
      if (error is PetApiException) {
        if (error.statusCode == 409)
          notifyError(EmailError('Email đã tồn tại'));
        else if (error.statusCode == 400) {
          notifyError(EmailError('Email không hợp lệ'));
        } else {
          notifyError(EmailError(error.message));
        }
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

  void _handleCodeSubmit(SubmitCode event) async {
    // TODO: define Error message
    FutureOr<void> _handleError(dynamic error) {
      if (error is PetApiException) {
        if (error.statusCode == 409)
          notifyError(CodeError('Email đã tồn tại'));
        else if (error.statusCode == 400) {
          notifyError(CodeError('Email không hợp lệ'));
        } else {
          notifyError(CodeError(error.message));
        }
      } else {
        notifyError(CodeError(error.toString()));
      }
    }

    try {
      if (event?.requireCode?.trim()?.isEmpty ?? true) {
        _handleError('Mã xác nhận không hợp lệ');
      }
      bool success = await accountService
          .checkCode(_account.email, event.requireCode)
          .catchError(_handleError);
      if (success) {
        add(CodeSuccess());
      } else {
        _handleError('Mã xác nhận không chính xác');
      }
    } catch (e) {
      _handleError(e);
    }
  }
}
