part of petisland_core.service;

abstract class LocalStorageService {
  String getToken();

  Future<bool> updateToken(String data);
}

class LocalStorageServiceImpl extends LocalStorageService {
  final LocalStorageRepository repository;

  LocalStorageServiceImpl(this.repository);

  @override
  String getToken() {
    return repository.getToken();
  }

  @override
  Future<bool> updateToken(String data) {
    return repository.updateToken(data);
  }
}
