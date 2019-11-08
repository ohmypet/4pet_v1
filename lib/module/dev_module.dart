import 'dart:io';

import 'package:ddi/di.dart';
import 'package:dio/dio.dart';
import 'package:petisland_core/petisland_core.dart';

export 'package:ddi/ddi.dart';

class DevModule extends AbstractModule {
  static const String normalApi = 'normal_client';

  // static const String
  @override
  void init() async {
    bind(normalApi).to(_buildClient());
    // bind(Login)
  }

  HttpClient _buildClient() {
    final BaseOptions baseOption = BaseOptions(
      baseUrl: Config.getString("api_host"),
      connectTimeout: 15000,
      receiveTimeout: 10000,
      headers: <String, dynamic>{HttpHeaders.contentTypeHeader: 'application/json'},
    );
    Dio dio = Dio(baseOption);
    return HttpClient.init(dio);
  }
}
