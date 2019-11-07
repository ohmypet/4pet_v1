part of petisland_core.config;

class RemoteConfig {
  Map<String, dynamic> defaultValue;

  RemoteConfig(this.defaultValue);

  int getInt(String key) {
    return defaultValue[key];
  }

  String getString(String key) {
    return defaultValue[key];
  }

  double getDouble(String key) {
    return defaultValue[key];
  }

  bool getBool(String key) {
    return defaultValue[key];
  }

  Map<String, dynamic> getAll() {
    return defaultValue;
  }
}
