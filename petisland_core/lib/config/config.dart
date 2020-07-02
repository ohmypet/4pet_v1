// import 'package:firebase_remote_config/firebase_remote_config.dart' as firebase;
library petisland_core.config;

import 'package:firebase_remote_config/firebase_remote_config.dart' as frc;
import 'package:petisland_core/utils/utils.dart';

import 'config.dev.dart' as dev;
import 'config.production.dart' as prod;

part 'firebase_config.dart';
part 'remote_config.dart';

class Config {
  static const Map<String, dynamic> _debug = <String, dynamic>{
    'api_host': dev.api_host,
    'chat_host': dev.chat_host,
    'max_image_per_post': 10,
    'google_api_key': dev.google_api_key,
    'rescue_api_host': dev.rescue_api_host,
    'google_host': 'https://maps.googleapis.com',
    'opencagedata_api_key': dev.opencagedata_api_key,
    'opencagedata_host': 'https://api.opencagedata.com',
  };

  static const Map<String, dynamic> _production = <String, dynamic>{
    'api_host': prod.api_host,
    'chat_host': prod.chat_host,
    'max_image_per_post': 10,
    'google_api_key': prod.google_api_key,
    'rescue_api_host': prod.rescue_api_host,
    'google_host': 'https://maps.googleapis.com',
    'opencagedata_api_key': prod.opencagedata_api_key,
    'opencagedata_host': 'https://api.opencagedata.com',
  };

  static RemoteConfig _config;

  static Map<String, dynamic> getAll() {
    return _config.getAll();
  }

  static bool getBool(String key) {
    return _config.getBool(key);
  }

  static String getChatHost() {
    return _config.getString('chat_host');
  }

  static double getDouble(String key) {
    return _config.getDouble(key);
  }

  static String getGoogleAPIKey() => getString('google_api_key');

  static String getGoogleHost() => getString('google_host');

  static int getInt(String key) {
    return _config.getInt(key);
  }

  static int getMaxImages() => getInt('max_image_per_post');

  static String getOpencagedataAPIKey() => getString('opencagedata_api_key');

  static String getOpencageHost() => getString('opencagedata_host');

  static String getString(String key) {
    return _config.getString(key);
  }

  static Future<void> initAsync(Mode mode) async {
    if (Mode.Debug == mode) {
      _config = RemoteConfig(_debug);
    } else {
      _config = await FireBaseRemoteConfig(_production)
        ..init();
    }
  }
}

enum Mode { Debug, Production }
