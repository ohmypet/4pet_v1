part of petisland_core.repository;

abstract class AccountRepository {
  Future<Account> requireCode(String email);

  Future<bool> checkCode(String email, String code);

  Future<Account> register(String email, String code, String username, String password,
      {User user});

  Future<LoginData> login(String username, String password);

  Future<LoginData> checkToken(String token);

  Future<bool> requireForgotPasswordCode(String email);

  Future<Account> forgotPassword(String email, String code, String password);
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
        .then((json) => LoginData.fromJson(json));
  }

  @override
  Future<Account> register(String email, String code, String username, String password,
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
        .then((json) => Account.fromJson(json));
  }

  @override
  Future<Account> requireCode(String email) {
    final Map<String, dynamic> params = <String, dynamic>{
      'email': email,
    };
    return client
        .get<Map<String, dynamic>>('$path/register/require-code', params: params)
        .then((json) => Account.fromJson(json));
  }

  @override
  Future<LoginData> checkToken(String token) {
    final Map<String, dynamic> headers = <String, dynamic>{'x-access-token': token};
    return client
        .get<Map<String, dynamic>>('$path/check-token',
            options: Options(headers: headers))
        .then((json) => LoginData.fromJson(json));
  }

  @override
  Future<bool> checkCode(String email, String code) {
    final Map<String, dynamic> params = <String, dynamic>{'email': email, 'code': code};
    Log.info('params: $params');
    return client.getRaw('$path/register/check-code', params: params).then((_) => true);
  }

  @override
  Future<Account> forgotPassword(String email, String code, String password) {
    final body = {'password': password};
    final params = {'email': email, 'code': code};
    return client
        .post<Map<String, dynamic>>('$path/forgot-password', body, params: params)
        .then((json) => Account.fromJson(json));
  }

  @override
  Future<bool> requireForgotPasswordCode(String email) {
    final params = {'email': email};
    return client
        .get<Map<String, dynamic>>('$path/forgot-password/require-code', params: params)
        .then((_) => true);
  }
}
