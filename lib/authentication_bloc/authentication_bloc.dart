library petisland.authentication;

import 'package:flutter/material.dart';
import 'package:flutter_template/petisland.dart';
import 'package:petisland_core/service/service.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  @protected
  LocalStorageService storageService;

  @protected
  AccountService accountService;

  bool isInit = false;

  void init() {
    isInit = true;
    accountService = DI.get(AccountService);
    storageService = DI.get(LocalStorageService);
  }

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    switch (event.runtimeType) {
      case AppStarted:
        yield AuthenticationUninitialized();
        _loadToken();
        break;
      case LoggedOut:
        yield UnAuthenticating();
        _removeToken();
        yield Unauthenticated();
        break;

      case LoggedIn:
        yield Authenticated();
        break;
      default:
    }
  }

  void _loadToken() {
    final String token = storageService.getToken();
    if (token is String) {
      _tryLogin();
    } else
      add(LoggedOut());
  }

  void _tryLogin() {
    accountService.checkToken().then((_) => add(LoggedIn())).catchError((_) => add(LoggedOut()));
  }

  void _removeToken() {
    storageService.updateToken(null);
  }
}
