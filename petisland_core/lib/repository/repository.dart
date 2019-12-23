library petisland_core.repository;

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:petisland_core/client/client.dart';
import 'package:petisland_core/domain/domain.dart';
import 'package:petisland_core/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

part 'account_repository.dart';
part 'local_storage_repository.dart';
part 'user_repository.dart';
part 'image_repository.dart';
part 'post_repository.dart';
part 'pet_category_repository.dart';
part 'tag_repository.dart';
part 'report_repository.dart';