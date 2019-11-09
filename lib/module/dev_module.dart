import 'dart:io';

import 'package:ddi/di.dart';
import 'package:dio/dio.dart';
import 'package:petisland_core/petisland_core.dart';
import 'package:petisland_core/repository/repository.dart';
import 'package:petisland_core/service/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:ddi/ddi.dart';

class DevModule extends AbstractModule {
  static const String normal_client = 'normal_client';
  static const String api_client = 'api_client';

  // static const String
  @override
  void init() async {
    bind(LocalStorageService).to(await _buildLocalService());
    bind(normal_client).to(_buildClient());
    bind(api_client).to(_buildApiClient());
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
}
