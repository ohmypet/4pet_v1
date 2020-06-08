// import 'package:firebase_remote_config/firebase_remote_config.dart' as firebase;
library petisland_core.config;

import 'package:firebase_remote_config/firebase_remote_config.dart' as frc;
import 'package:petisland_core/utils/utils.dart';
import 'config.dev.dart' as dev;
import 'config.production.dart' as prod;

part 'firebase_config.dart';

part 'remote_config.dart';

enum Mode { Debug, Production }

class Config {
  static const Map<String, dynamic> _debug = <String, dynamic>{
    'api_host': dev.api_host,
    'chat_host': dev.chat_host,
    'max_image_per_post': 10,
  };

  static const Map<String, dynamic> _production = <String, dynamic>{
    'api_host': prod.api_host,
    'chat_host': prod.chat_host,
    'max_image_per_post': 10,
  };

  static RemoteConfig _config;

  static Future<void> initAsync(Mode mode) async {
    if (Mode.Debug == mode) {
      _config = RemoteConfig(_debug);
    } else {
      _config = await FireBaseRemoteConfig(_production)
        ..init();
    }
  }

  static int getInt(String key) {
    return _config.getInt(key);
  }

  static String getString(String key) {
    return _config.getString(key);
  }

  static double getDouble(String key) {
    return _config.getDouble(key);
  }

  static bool getBool(String key) {
    return _config.getBool(key);
  }

  static Map<String, dynamic> getAll() {
    return _config.getAll();
  }

  static String getChatHost() {
    return _config.getString('chat_host');
  }

  static int getMaxImages() => getInt('max_image_per_post');
}
