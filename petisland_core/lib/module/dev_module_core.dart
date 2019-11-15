part of petisland_core.module;

class DevModuleCore extends AbstractModule {
  static const String normal_client = 'normal_client';
  static const String api_client = 'api_client';

  // static const String
  @override
  void init() async {
    bind(LocalStorageService).to(await _buildLocalService());
    bind(normal_client).to(_buildClient());
    bind(api_client).to(_buildApiClient());
    bind(AccountService).to(_buildAccountService());
  }

  Future<LocalStorageService> _buildLocalService() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final LocalStorageRepository repository = LocalStorageRepositoryImpl(preferences);
    return LocalStorageServiceImpl(repository);
  }

  HttpClient _buildClient() {
    final BaseOptions baseOption = BaseOptions(
      baseUrl: Config.getString("api_host"),
      connectTimeout: 15000,
      receiveTimeout: 10000,
      headers: <String, dynamic>{HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'},
    );
    Dio dio = Dio(baseOption);
    return HttpClient.init(dio);
  }

  HttpClient _buildApiClient() {
    final BaseOptions baseOption = BaseOptions(
      baseUrl: Config.getString("api_host"),
      connectTimeout: 15000,
      receiveTimeout: 10000,
      headers: <String, dynamic>{HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'},
    );
    Dio dio = Dio(baseOption);
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: (DioError ex) => ex,
        onResponse: (Response<dynamic> reponse) => reponse,
      ),
    );
    return HttpClient.init(dio);
  }

  RequestOptions _onRequest(RequestOptions options) {
    final LocalStorageService service = DI.get<LocalStorageService>(LocalStorageService);
    final String token = service.getToken();
    if (token is String) {
      options.headers['x-access-token'] = token;
    } else {
      throw PetApiException(statusCode: PetApiException.no_auth);
    }
    return options;
  }

  AccountService _buildAccountService() {
    final HttpClient client = get<HttpClient>(normal_client);
    final AccountReposity reposity = AccountReposityImpl(client);
    return AccountServiceImpl(reposity);
  }
}
