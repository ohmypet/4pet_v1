part of petisland_core.config;

class FireBaseRemoteConfig extends RemoteConfig {
  frc.RemoteConfig _conf;

  FireBaseRemoteConfig(Map<String, dynamic> value) : super(value);

  Future<void> init() async {
    return frc.RemoteConfig.instance.then<void>((frc.RemoteConfig config) {
      return config
        ..setDefaults(this.defaultValue ?? <String, dynamic>{})
        ..fetch(expiration: Duration(hours: 1))
        ..activateFetched()
        ..addListener(() {
          getAll().forEach((String key, dynamic value) => Log.debug('Key: $key, value: $value'));
        });
    }).catchError((dynamic ex) {
      Log.error('Fail to fetch config from firebase: $ex');
    });
  }

  @override
  int getInt(String key) {
    return _conf == null ? defaultValue[key] : _conf.getInt(key);
  }

  @override
  String getString(String key) {
    return _conf == null ? defaultValue[key] : _conf.getString(key);
  }

  @override
  double getDouble(String key) {
    return _conf == null ? defaultValue[key] : _conf.getDouble(key);
  }

  @override
  bool getBool(String key) {
    return _conf == null ? defaultValue[key] : _conf.getBool(key);
  }

  @override
  Map<String, dynamic> getAll() {
    return _conf == null ? defaultValue : _conf.getAll();
  }
}
