part of petisland_core.repository;

abstract class TagRepository {
  Future<List<Tag>> getTags(final String title);
}

class TagRepositoryImpl extends TagRepository {
  final HttpClient client;

  TagRepositoryImpl(this.client);

  @override
  Future<List<Tag>> getTags(final String title) {
    final Map<String, dynamic> params = <String, dynamic>{"title": title};
    return client
        .get<List<dynamic>>("/api/tag", params: params)
        .then((List<dynamic> tags) => _parseTags(tags));
  }

  List<Tag> _parseTags(List<dynamic> tags) {
    return tags.cast<Map<String, dynamic>>().map((Map<String, dynamic> json) => Tag.fromJson(json)).toList();
  }
}
