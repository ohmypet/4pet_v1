part of petisland_core.service;

abstract class LocationService {
  Future<LocationResponse> getSuggestionLocation(String text);
}

class LocationServiceImpl extends LocationService {
  final LocationRepository repository;

  LocationServiceImpl(this.repository);

  @override
  Future<LocationResponse> getSuggestionLocation(String text) {
    if (text?.isNotEmpty == true) {
      return repository
          .getSuggestionLocation(text)
          .catchError((ex) => LocationResponse.empty());
    } else {
      return Future.value(LocationResponse.empty());
    }
  }
}
