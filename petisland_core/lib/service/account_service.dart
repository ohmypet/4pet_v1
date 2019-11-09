part of petisland_core.service;

abstract class AccountService {
  Future<Account> requireCode(String email);

  Future<Account> register(String email, String code, String username, String password);

  Future<LoginData> login(String email, String password);
}

class AccountServiceImpl extends AccountService {
  final AccountReposity reposity;

  AccountServiceImpl(this.reposity);

  @override
  Future<LoginData> login(String email, String password) {
    return reposity.login(email, password);
  }

  @override
  Future<Account> register(String email, String code, String username, String password) {
    return reposity.register(email, code, username, password);
  }

  @override
  Future<Account> requireCode(String email) {
    return requireCode(email);
  }
}
