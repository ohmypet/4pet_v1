part of petisland_core.client;

@immutable
class HttpClient {
  @protected
  final Dio dio;

  HttpClient.init(Dio dio) : dio = dio;

  static Map<String, dynamic> _getParams(Map<String, dynamic> params) => params ?? <String, dynamic>{};

  static Options _getOptions(Options options) =>
      options is Options ? options : Options(responseType: ResponseType.plain);

  Future<String> getRaw(String path, {Map<String, dynamic> params, Options options}) {
    return dio
        .get<String>(path, queryParameters: _getParams(params), options: _getOptions(options))
        .then((Response<String> response) => response.data)
        .catchError((dynamic e) => _handleError(path, e));
  }

  Future<T> get<T>(String path, {Map<String, dynamic> params, Options options}) {
    return dio
        .get<String>(path, queryParameters: _getParams(params), options: _getOptions(options))
        .then((Response<String> response) => _handleResult<T>(response))
        .catchError((dynamic e) => _handleError(path, e));
  }

  Future<T> post<T>(String path, dynamic body,
      {Map<String, dynamic> params, ProgressCallback onSendProgress, Options options}) {
    return dio
        .post<String>(path,
            data: body,
            queryParameters: _getParams(params),
            onSendProgress: onSendProgress,
            options: _getOptions(options))
        .then((Response<String> response) => _handleResult<T>(response))
        .catchError((dynamic e) => _handleError(path, e));
  }

  Future<T> put<T>(String path, dynamic body, {Options options}) {
    return dio
        .put<String>(path, data: body, options: _getOptions(options))
        .then((Response<String> response) => _handleResult<T>(response))
        .catchError((dynamic e) => _handleError(path, e));
  }

  Future<T> delete<T>(String path, {Options options}) {
    return dio
        .delete<String>(path, options: _getOptions(options))
        .then((Response<String> response) => _handleResult<T>(response))
        .catchError((dynamic ex) => _handleError(path, ex));
  }

  FutureOr<T> _handleResult<T>(Response<String> response) async {
    if (response.statusCode == HttpStatus.ok) {
      final String body = response.data;
      final T map = json.decode(body);
      return map;
    } else {
      throw _getApiException(response);
    }
    // return Future<T>.value(json.decode(body));
  }

  PetApiException _getApiException(Response<dynamic> response) {
    final String body = response?.data;
    if (body != null) {
      final Map<String, dynamic> map = json.decode(body);
      return PetApiException.fromJson(map);
    } else {
      return null;
    }
  }

  void _handleError(String path, dynamic ex) {
    Log.error('_handleError:: $ex');
    if (ex is PetApiException) {
      throw ex;
    } else if (ex is DioError) {
      throw _handleDioError(path, ex);
    } else
      throw ex;
  }

  Exception _handleDioError(String path, DioError ex) {
    Log.error('path: $path ex: $ex');
    final PetApiException error = _getApiException(ex.response) ?? PetException.fromException(ex);
    throw error;
  }
}
