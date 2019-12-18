library petisland.authentication;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/petisland.dart';
import 'package:petisland_core/service/service.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends TBloc<AuthenticationEvent, AuthenticationState> {
  @protected
  static final LocalStorageService storageService = DI.get(LocalStorageService);

  @protected
  static final AccountService accountService = DI.get(AccountService);

  @protected
  static final PetCategoryService categoryService = DI.get(PetCategoryService);

  final List<PetCategory> categories = [];

  bool isInit = false;

  void init() {
    isInit = true;
    reload();
  }

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  void _loadToken() {
    final String token = storageService.getToken();
    if (token is String) {
      _tryLogin(token);
    } else {
      logout();
    }
  }

  void _tryLogin(String token) {
    accountService.checkToken(token).then((_) => add(LoggedIn())).catchError((_) => add(LoggedOut()));
  }

  void _removeToken() {
    storageService.updateToken(null);
  }

  @override
  final Duration delayEvent = const Duration(milliseconds: 50);

  @override
  Stream<AuthenticationState> errorToState(BaseErrorEvent event) async* {
    yield AuthenticatingError(event.message);
  }

  @override
  Stream<AuthenticationState> eventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case AppStarted:
        yield AuthenticationUninitialized();
        _loadToken();
        break;

      case LoggedOut:
        yield UnAuthenticating();
        await Future<void>.delayed(const Duration(milliseconds: 150));
        _removeToken();
        yield Unauthenticated();
        break;

      case LoggedIn:
        categories.clear();
        final List<PetCategory> newCategories = await categoryService.getPetCategories();
        categories.addAll(newCategories);
        yield Authenticated();
        break;
      default:
    }
  }

  void reload() {
    add(AppStarted());
  }

  void logout() {
    add(LoggedOut());
  }
}
