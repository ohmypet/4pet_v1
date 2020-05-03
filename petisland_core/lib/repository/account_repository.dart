part of petisland_core.repository;

abstract class AccountRepository {
  Future<Account> requireCode(String email);

  Future<bool> checkCode(String email, String code);

  Future<Account> register(
      String email, String code, String username, String password,
      {User user});

  Future<LoginData> login(String username, String password);

  Future<LoginData> checkToken(String token);
}

class AccountReposityImpl extends AccountRepository {
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
  Future<Account> register(
      String email, String code, String username, String password,
      {User user}) {
    final Map<String, dynamic> params = <String, dynamic>{
      'email': email,
      'code': code,
    };
    final Map<String, dynamic> body = <String, dynamic>{
      'username': username,
      'password': password,
      'settings': {},
      'user': user?.toCreateJson(),
    }..removeWhere((item, value) => value == null);

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
  Future<LoginData> checkToken(String token) {
    final Map<String, dynamic> headers = <String, dynamic>{
      'x-access-token': token
    };
    return client
        .get<Map<String, dynamic>>('$path/check-token',
            options: Options(headers: headers))
        .then((Map<String, dynamic> json) => LoginData.fromJson(json));
  }

  @override
  Future<bool> checkCode(String email, String code) {
    final Map<String, dynamic> params = <String, dynamic>{
      'email': email,
      'code': code
    };
    return client.getRaw('$path/check-code', params: params).then((_) => true);
  }
}
