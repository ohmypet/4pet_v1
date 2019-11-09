part of petisland_core.repository;

abstract class LocalStorageRepository {
  String getToken();

  Future<bool> updateToken(String data);
}

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final SharedPreferences preferences;

  LocalStorageRepositoryImpl(this.preferences);

  @override
  String getToken() {
    return preferences.getString(PetIslandConstants.key_token);
  }

  @override
  Future<bool> updateToken(String data) {
    return preferences.setString(PetIslandConstants.key_token, data);
  }
}
