part of petisland_core.service;

abstract class LocationService {
  Future<LocationResponse> getSuggestionLocation(String text);
}

class LocationServiceImpl extends LocationService {
  final LocationRepository repository;

  LocationServiceImpl(this.repository);

  @override
  Future<LocationResponse> getSuggestionLocation(String text) {
    return repository.getSuggestionLocation(text);
  }
}