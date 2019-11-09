part of petisland_core.repository;

abstract class AccountReposity {
  Future<Account> requireCode(String email);

  Future<Account> register(String email, String code, String username, String password);

  Future<LoginData> login(String email, String password);
}

class AccountReposityImpl extends AccountReposity {
  @protected
  final HttpClient client;

  AccountReposityImpl(this.client);

  @override
  Future<LoginData> login(String email, String password) {
    final Map<String, dynamic> body = <String, dynamic>{
      'email': email,
      'password': password,
    };
    return client.post('/api/account/login', body).then((Map<String, dynamic> json) => LoginData.fromJson(json));
  }

  @override
  Future<Account> register(String email, String code, String username, String password) {
    final Map<String, dynamic> params = <String, dynamic>{
      'email': email,
      'code': code,
    };
    final Map<String, dynamic> body = <String, dynamic>{
      'username': username,
      'password': password,
    };
    return client
        .post('/api/account/register', body, params: params)
        .then((Map<String, dynamic> json) => Account.fromJson(json));
  }

  @override
  Future<Account> requireCode(String email) {
    final Map<String, dynamic> params = <String, dynamic>{
      'email': email,
    };
    return client
        .get('/api/account/require-code', params: params)
        .then((Map<String, dynamic> json) => Account.fromJson(json));
  }
}
