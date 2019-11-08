part of petisland_core.client;

@immutable
class HttpClient {
  @protected
  final Dio dio;

  HttpClient.init(Dio dio) : dio = dio;

  static Map<String, dynamic> _getParams(Map<String, dynamic> params) => params ?? <String, dynamic>{};

  static Options _getOptions(Options options) =>
      options is Options ? options : Options(responseType: ResponseType.plain);

  Future<Map<String, dynamic>> get(String path, {Map<String, dynamic> params, Options options}) {
    return dio
        .get<String>(path, queryParameters: _getParams(params), options: _getOptions(options))
        .then((Response<String> response) => _handleResult(response))
        .catchError((dynamic e) => _handleError(path, e));
  }

  Future<Map<String, dynamic>> post(String path, dynamic body,
      {Map<String, dynamic> params, ProgressCallback onSendProgress, Options options}) {
    return dio
        .post<String>(path,
            data: body,
            queryParameters: _getParams(params),
            onSendProgress: onSendProgress,
            options: _getOptions(options))
        .then((Response<String> response) => _handleResult(response))
        .catchError((dynamic e) => _handleError(path, e));
  }

  Future<Map<String, dynamic>> put(String path, dynamic body, {Options options}) {
    return dio
        .put<String>(path, data: body, options: _getOptions(options))
        .then((Response<String> response) => _handleResult(response))
        .catchError((dynamic e) => _handleError(path, e));
  }

  Future<Map<String, dynamic>> delete<T>(String path, {Options options}) {
    return dio
        .delete<String>(path, options: _getOptions(options))
        .then((Response<String> response) => _handleResult(response))
        .catchError((dynamic ex) => _handleError(path, ex));
  }

  FutureOr<Map<String, dynamic>> _handleResult<T>(Response<dynamic> response) async {
    if (response.statusCode == HttpStatus.ok) {
      final String body = response.data;
      final Map<String, dynamic> map = json.decode(body);
      return map;
    } else {
      final String body = response.data;
      final Map<String, dynamic> map = json.decode(body);
      throw PetApiException.fromJson(map);
    }
    // return Future<T>.value(json.decode(body));
  }

  void _handleError(String path, Exception ex) {
    if (ex is DioError) {
      _handleDioError(path, ex);

      throw PetException.fromException(ex);
    } else if (ex is PetApiException) {
      throw ex;
    }
  }

  void _handleDioError(String path, DioError ex) {
    Log.error(ex);
  }
}
