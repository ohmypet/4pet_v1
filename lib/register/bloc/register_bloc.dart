part of petisland.register.bloc;

class RegisterBloc extends TBloc<RegisterEvent, RegisterState> {
  static final AccountService accountService = DI.get<AccountService>(AccountService);
  Account _account;
  String _code;

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
        yield Loading();
        _handleCodeSubmit(event);
        break;
      case SubmitAccount:
        yield Loading();
        _handleAccountSubmit(event);
        break;
      case EmailSuccess:
        yield EmailSuccessful();
        break;
      case CodeSuccess:
        yield CodeSuccessful();
        break;
      case AccountSuccess:
        yield AccountSuccessful();
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

  void submitAccount(String username, String password, {User user}) {
    this.add(SubmitAccount(username, password, user: user));
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
    accountService.requireCode(event.email).then(_handleRequireCodeSuccess).catchError(_handleError);
  }

  void _handleCodeSubmit(SubmitCode event) async {
    FutureOr<void> _handleCodeSuccess(bool success, String requireCode) {
      _code = requireCode;
      add(CodeSuccess());
    }

    FutureOr<void> _handleError(dynamic error) {
      Log.error('_handleCodeSubmit:: $error');
      if (error is PetApiException) {
        if (error.statusCode == 408)
          notifyError(CodeError('Mã xác nhận không hợp lệ'));
        else if (error.statusCode == 400) {
          notifyError(CodeError('Mã xác nhận không hợp lệ'));
        } else {
          notifyError(CodeError(error.message));
        }
      } else {
        notifyError(CodeError(error.toString()));
      }
    }

    accountService
        .checkCode(_account.email, event.requireCode)
        .then((_) => _handleCodeSuccess(_, event.requireCode))
        .catchError(_handleError);
  }

  void _handleAccountSubmit(SubmitAccount event) async {
    bool accountIsNotValid(SubmitAccount event) {
      return (event?.userName?.trim()?.isEmpty ?? true & event?.password?.trim()?.isEmpty ?? true);
    }

    FutureOr<void> _handleAccountSuccess(Account account) {
      add(AccountSuccess());
    }

    FutureOr<void> _handleError(dynamic error) {
      Log.error('_handleCodeSubmit:: $error');
      if (error is PetApiException) {
        if (error.statusCode == 408)
          notifyError(CodeError('Mã xác nhận không hợp lệ'));
        else if (error.statusCode == 400) {
          notifyError(CodeError('Mã xác nhận không hợp lệ'));
        } else {
          notifyError(CodeError(error.message));
        }
      } else {
        notifyError(CodeError(error.toString()));
      }
    }

    if (accountIsNotValid(event)) {
      _handleError('Tài khoản không hợp lệ');
    }
    accountService
        .register(
          _account.email,
          _code,
          event.userName,
          event.password,
          user: event.user,
        )
        .then((_) => _handleAccountSuccess(_))
        .catchError(_handleError);
  }
}
