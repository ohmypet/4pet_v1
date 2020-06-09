part of petisland_core.module;

abstract class _KeysCached {
  static const String image_cache = 'image_cached';
}

abstract class DIKeys {
  static const String dio_client = 'dio_client';
  static const String cache_image = 'cache_image';
}

class DevModuleCore extends AbstractModule {
  static const String normal_client = 'normal_client';
  static const String api_client = 'api_client';
  static const String api_upload_image = 'api_upload_image';
  static const String google_api = 'google_api';

  @override
  void init() async {
    timeAgo.setLocaleMessages('vi', TViShortMessage());

    bind(LocalStorageService).to(await _buildLocalService());
    bind(normal_client).to(_buildClient());
    bind(api_client).to(_buildApiClient());
    bind(api_upload_image).to(_buildClientUpload());
    bind(google_api).to(_buildGoogleApi());

    bind(AccountService).to(_buildAccountService());
    bind(DIKeys.cache_image).to(await _buildCacheImage());
    bind(ImageService).to(_buildImageService());
    bind(PetCategoryService).to(_buildPetCategoryService());
    bind(PostService).to(_buildPostService());
    bind(TagService).to(_buildTagService());
    bind(ReportService).to(_buildReportService());
    bind(NotificationService).to(_buildNotificationService());
    bind(LocationRepository).to(_buildLocationRepository());
    bind(LocationService).to(_buildLocationService());
  }

  Future<LocalStorageService> _buildLocalService() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final LocalStorageRepository repository = LocalStorageRepositoryImpl(preferences);
    return LocalStorageServiceImpl(repository);
  }

  Future<BaseCacheManager> _buildCacheImage() async {
    try {
      final Directory directory = await getTemporaryDirectory();

      return TCacheService(
        _KeysCached.image_cache,
        directory,
        maxAgeCacheObject: const Duration(days: 90),
        maxNrOfCacheObjects: 1000,
        fileService: HttpFileService(httpClient: http.Client()),
      );
    } catch (ex) {
      Log.error(ex);
      return null;
    }
  }

  HttpClient _buildClient() {
    final BaseOptions baseOption = BaseOptions(
      baseUrl: Config.getString('api_host'),
      connectTimeout: 15000,
      receiveTimeout: 10000,
      headers: <String, dynamic>{
        HttpHeaders.contentTypeHeader: Headers.formUrlEncodedContentType,
      },
    );
    Dio dio = Dio(baseOption);
    return HttpClient.init(dio);
  }

  HttpClient _buildGoogleApi() {
    final BaseOptions baseOption = BaseOptions(
      baseUrl: Config.getGoogleHost(),
      connectTimeout: 15000,
      receiveTimeout: 10000,
      headers: <String, dynamic>{
        HttpHeaders.contentTypeHeader: Headers.formUrlEncodedContentType,
      },
    );
    Dio dio = Dio(baseOption);
    return HttpClient.init(dio);
  }

  HttpClient _buildApiClient() {
    final BaseOptions baseOption = BaseOptions(
      baseUrl: Config.getString('api_host'),
      connectTimeout: 15000,
      receiveTimeout: 10000,
      headers: <String, dynamic>{
        HttpHeaders.contentTypeHeader: Headers.formUrlEncodedContentType,
      },
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

  HttpClient _buildClientUpload() {
    final BaseOptions baseOption = BaseOptions(
      baseUrl: Config.getString('api_host'),
      connectTimeout: 35000,
      receiveTimeout: 60000,
      headers: <String, dynamic>{
        HttpHeaders.contentTypeHeader: Headers.formUrlEncodedContentType,
      },
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
    final LocalStorageService service = get<LocalStorageService>(LocalStorageService);
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
    final AccountRepository repository = AccountReposityImpl(client);
    return AccountServiceImpl(repository);
  }

  ImageService _buildImageService() {
    final HttpClient client = get(api_upload_image);
    final ImageRepository repository = ImageRepositoryImpl(client);
    return ImageServiceImpl(repository);
  }

  PostService _buildPostService() {
    final HttpClient client = get<HttpClient>(api_client);
    final PostRepository repository = PostRepositoryImpl(client);
    return PostServiceImpl(repository);
  }

  PetCategoryService _buildPetCategoryService() {
    final HttpClient client = get<HttpClient>(api_client);
    final PetCategoryRepository repository = PetCategoryRepositoryImpl(client);
    return PetCategoryServiceImpl(repository);
  }

  TagService _buildTagService() {
    final HttpClient client = get<HttpClient>(api_client);
    final TagRepository repository = TagRepositoryImpl(client);
    return TagServiceImpl(repository);
  }

  ReportService _buildReportService() {
    final HttpClient client = get<HttpClient>(api_client);
    final repository = ReportRepositoryImpl(client);
    return ReportServiceImpl(repository);
  }

  NotificationService _buildNotificationService() {
    final HttpClient client = get<HttpClient>(api_client);
    final repository = NotificationRepositoryImpl(client);
    return NotificationServiceImpl(repository);
  }

  LocationRepository _buildLocationRepository() {
    final HttpClient client = get<HttpClient>(google_api);
    return LocationRepositoryImpl(client);
  }

  LocationService _buildLocationService() {
    final LocationRepository repository = get<LocationRepository>(LocationRepository);
    return LocationServiceImpl(repository);
  }
}
