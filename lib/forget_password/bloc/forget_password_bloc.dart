import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_template/petisland.dart';
import 'package:meta/meta.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  String email;
  String code;
  String password;
  String rePassword;
  ForgetPasswordBloc()
      : email = '',
        code = '',
        password = '',
        rePassword = '';
  @override
  ForgetPasswordState get initialState => StepOneState();

  @override
  Stream<ForgetPasswordState> mapEventToState(
    ForgetPasswordEvent event,
  ) async* {
    switch (event.runtimeType) {
      case TypingEmail:
        yield* _handleTypingEmail(event);
        break;
      case TypingCode:
        yield* _handleTypingCode(event);
        break;
      case TypingNewPassword:
        yield* _handleTypingNewPassword(event);
        break;
      case TypingRePassword:
        yield* _handleTypingRePassword(event);
        break;
      case SubmitEmail:
        yield* _handleSubmitEmail(event);
        break;
      case SubmitCode:
        yield* _handleSubmitCode(event);
        break;
      case SubmitNewPassword:
        yield* _handleSubmitNewPassword(event);
        break;
    }
  }

  Stream<ForgetPasswordState> _handleTypingEmail(TypingEmail event) async* {
    email = event.email;
    yield StepOneState();
  }

  Stream<ForgetPasswordState> _handleTypingCode(TypingCode event) async* {
    code = event.code;
    yield StepTwoState();
  }

  Stream<ForgetPasswordState> _handleTypingNewPassword(
      TypingNewPassword event) async* {
    password = event.password;
    yield StepThreeState();
  }

  Stream<ForgetPasswordState> _handleTypingRePassword(
      TypingRePassword event) async* {
    rePassword = event.rePassword;
    yield StepThreeState();
  }

  Stream<ForgetPasswordState> _handleSubmitEmail(SubmitEmail event) async* {
    try {
      DI.get<AccountService>(AccountService).requireForgotPasswordCode(email);
      yield StepTwoState();
    } catch (ex, trace) {
      Log.error(ex);
      Log.error(trace);
      yield Error(_getMessageFromError(ex));
    }
  }

  Stream<ForgetPasswordState> _handleSubmitCode(SubmitCode event) async* {
    try {
      yield StepThreeState();
    } catch (ex, trace) {
      Log.error(ex);
      Log.error(trace);
      yield Error(_getMessageFromError(ex));
    }
  }

  Stream<ForgetPasswordState> _handleSubmitNewPassword(
      SubmitNewPassword event) async* {
    try {
      bool emailIsValid = email.trim().isNotEmpty;
      bool passwordIsValid = password == rePassword;
      if (emailIsValid && passwordIsValid) {
        yield Loading();
        final AccountService service = DI.get(AccountService);
        Account accountAfterReset = await service.forgotPassword(
          email,
          code,
          password,
        );
        yield SuccessForgetPasswordState(accountAfterReset);
      } else if (!passwordIsValid) {
        yield Error('New password is not equal repassword');
      }
    } catch (ex, trace) {
      Log.error(ex);
      Log.error(trace);
      yield Error(_getMessageFromError(ex));
      yield* goToStepWhenCodeError(ex);
    }
  }

  String _getMessageFromError(ex) {
    if (ex is PetApiException) {
      return ex.message;
    }
    return 'Error! Please try again.';
  }

  Stream<ForgetPasswordState> goToStepWhenCodeError(ex) async* {
    if (ex is PetApiException && ex.message == 'Code is incorrect') {
      yield StepTwoState();
    }
    if (ex is PetApiException && ex.message == 'Code is expired') {
      yield StepOneState();
    }
  }
}
