part of petisland_core.service;

abstract class AccountService {
  Future<Account> requireCode(String email);

  Future<Account> register(String email, String code, String username, String password,
      {User user});

  Future<LoginData> login(String username, String password);

  Future<LoginData> checkToken(String token);

  Future<bool> checkCode(String email, String code);

  Future<bool> requireForgotPasswordCode(String email);

  Future<Account> forgotPassword(String email, String code, String password);

  Future<Account> getDetails();

  Future<List<CoinHistory>> getCoinHistory(int offset, int limit);
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
  Future<LoginData> checkToken(String token) {
    return repository.checkToken(token);
  }

  @override
  Future<bool> checkCode(String email, String code) {
    return repository.checkCode(email, code);
  }

  @override
  Future<Account> forgotPassword(String email, String code, String password) {
    return repository.forgotPassword(email, code, password);
  }

  @override
  Future<bool> requireForgotPasswordCode(String email) {
    return repository.requireForgotPasswordCode(email);
  }

  @override
  Future<Account> getDetails() {
    return repository.getDetails();
  }

  Future<List<CoinHistory>> getCoinHistory(int offset, int limit) {
    return repository.getCoinHistory(offset, limit);
  }
}
