part of petisland_core.service;

abstract class AccountService {
  Future<Account> requireCode(String email);

  Future<Account> register(String email, String code, String username, String password);

  Future<LoginData> login(String username, String password);

  Future<void> checkToken(String token);
}

class AccountServiceImpl extends AccountService {
  @protected
  final AccountReposity reposity;

  AccountServiceImpl(this.reposity);

  @override
  Future<LoginData> login(String username, String password) {
    return reposity.login(username, password);
  }

  @override
  Future<Account> register(String email, String code, String username, String password) {
    return reposity.register(email, code, username, password);
  }

  @override
  Future<Account> requireCode(String email) {
    return reposity.requireCode(email);
  }

  @override
  Future<void> checkToken(String token) {
    return reposity.checkToken(token);
  }
}
