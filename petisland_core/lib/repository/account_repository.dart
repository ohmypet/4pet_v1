part of petisland_core.repository;

abstract class AccountReposity {
  Future<Account> requireCode(String email);

  Future<Account> register(String email, String code, String username, String password);

  Future<LoginData> login(String username, String password);

  Future<void> checkToken(String token);
}

class AccountReposityImpl extends AccountReposity {
  static const String path = '/api/account';
  @protected
  final HttpClient client;

  AccountReposityImpl(this.client);

  @override
  Future<LoginData> login(String username, String password) {
    final Map<String, dynamic> body = <String, dynamic>{
      'username': username,
      'password': password,
    };
    return client
        .post<Map<String, dynamic>>('$path/login', body)
        .then((Map<String, dynamic> json) => LoginData.fromJson(json));
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
        .post<Map<String, dynamic>>('$path/register', body, params: params)
        .then((Map<String, dynamic> json) => Account.fromJson(json));
  }

  @override
  Future<Account> requireCode(String email) {
    final Map<String, dynamic> params = <String, dynamic>{
      'email': email,
    };
    return client
        .get<Map<String, dynamic>>('$path/require-code', params: params)
        .then((Map<String, dynamic> json) => Account.fromJson(json));
  }

  @override
  Future<void> checkToken(String token) {
    final Map<String, dynamic> headers = <String, dynamic>{'x-access-token': token};
    return client.get('$path/check-token', options: Options(headers: headers));
  }
}
