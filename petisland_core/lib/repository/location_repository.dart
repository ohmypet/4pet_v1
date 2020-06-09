part of petisland_core.repository;

abstract class LocationRepository {
  Future<LocationResponse> getSuggestionLocation(String text);
}

class LocationRepositoryImpl extends LocationRepository {
  final HttpClient client;

  LocationRepositoryImpl(this.client);

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
