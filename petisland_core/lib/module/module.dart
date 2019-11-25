library petisland_core.module;

import 'dart:io';

import 'package:ddi/di.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:petisland_core/petisland_core.dart';
import 'package:petisland_core/petisland_core.dart' as prefix0;
import 'package:petisland_core/repository/repository.dart';
import 'package:petisland_core/service/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

export 'package:ddi/ddi.dart';

part 'dev_module_core.dart';
part 'prod_module_core.dart';
