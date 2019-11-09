library petisland_core.module;


import 'dart:io';

import 'package:ddi/di.dart';
import 'package:dio/dio.dart';
import 'package:petisland_core/petisland_core.dart';
import 'package:petisland_core/repository/repository.dart';
import 'package:petisland_core/service/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:ddi/ddi.dart';

part 'dev_module_core.dart';
part 'prod_module_core.dart';