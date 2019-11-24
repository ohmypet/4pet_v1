// import 'package:firebase_remote_config/firebase_remote_config.dart' as firebase;
library petisland_core.config;

import 'package:firebase_remote_config/firebase_remote_config.dart' as frc;

import '../util/log.dart';

part 'firebase_config.dart';
part 'remote_config.dart';
part 'constant.dart';

enum Mode { Debug, Production }

class Config {
  static const Map<String, dynamic> _debug = <String, dynamic>{
    'api_host': 'https://petisland.herokuapp.com',
  };

  static const Map<String, dynamic> _production = <String, dynamic>{
    'api_host': 'https://petisland.herokuapp.com',
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
}
