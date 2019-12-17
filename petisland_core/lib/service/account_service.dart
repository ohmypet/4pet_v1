part of petisland_core.service;

abstract class AccountService {
  Future<Account> requireCode(String email);

  Future<Account> register(String email, String code, String username, String password,
      {User user});

  Future<LoginData> login(String username, String password);

  Future<void> checkToken(String token);

  Future<bool> checkCode(String email, String code);
}

class AccountServiceImpl extends AccountService {
  @protected
  final AccountRepository repository;

  AccountServiceImpl(this.repository);

  @override
  Future<LoginData> login(String username, String password) {
    return repository.login(username, password);
  }

  @override
  Future<Account> register(String email, String code, String username, String password,
      {User user}) {
    return repository.register(email, code, username, password, user: user);
  }

  @override
  Future<Account> requireCode(String email) {
    return repository.requireCode(email);
  }

  @override
  Future<void> checkToken(String token) {
    return repository.checkToken(token);
  }

  @override
  Future<bool> checkCode(String email, String code) {
    return repository.checkCode(email, code);
  }
}
