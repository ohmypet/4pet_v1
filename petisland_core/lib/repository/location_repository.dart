part of petisland_core.repository;

abstract class LocationRepository {
  Future<LocationResponse> getSuggestionLocation(String text);
}

class GoogleLocationRepository extends LocationRepository {
  final HttpClient client;

  GoogleLocationRepository(this.client);

  @override
  Future<LocationResponse> getSuggestionLocation(String text) {
    final params = {
      'input': text,
      'key': Config.getGoogleAPIKey(),
    };
    return client
        .get<Map<String, dynamic>>('/maps/api/place/autocomplete/json', params: params)
        .then((json) => LocationResponse.fromJson(json));
  }
}

class OpencagedataLocationRepository extends LocationRepository {
    final HttpClient client;

  OpencagedataLocationRepository(this.client);

  @override
  Future<LocationResponse> getSuggestionLocation(String text) {
    final params = {
      'q': text,
      'key': Config.getOpencagedataAPIKey(),
    };
    return client
        .get<Map<String, dynamic>>('/geocode/v1/json', params: params)
        .then((json) => LocationResponse.fromJson(json));
  }
}