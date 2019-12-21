part of petisland_core.repository;

abstract class PostRepository {
  Future<Post> create(PostCreateModal postModal);

  Future<Post> like(String id);

  Future<List<Item>> getPosts(
      int offset, int limit, String categoryType, String petCategoryId);

  Future<Post> delete(String id);

  Future<Post> edit(PostEditModal postModal);
}

class PostRepositoryImpl extends PostRepository {
  final HttpClient client;

  PostRepositoryImpl(this.client);

  @override
  Future<Post> create(PostCreateModal postModal) {
    return client
        .post<Map<String, dynamic>>('/api/post', postModal.toJson())
        .then((Map<String, dynamic> json) => Post.fromJson(json));
  }

  @override
  Future<Post> like(String id) {
    return client
        .get<Map<String, dynamic>>('/api/post/$id/react')
        .then((Map<String, dynamic> json) => Post.fromJson(json));
  }

  @override
  Future<List<Item>> getPosts(
      int offset, int limit, String categoryType, String petCategoryId) {
    final Map<String, dynamic> params = <String, dynamic>{
      'offset': offset,
      'limit': limit,
      'category': categoryType,
      'petCategoryId': petCategoryId
    }..removeWhere((_, dynamic value) => value == null);

    Log.debug(params);

    return client.get<List<dynamic>>('/api/post', params: params).then(_parseToListPost);
  }

  Future<List<Item>> _parseToListPost(List<dynamic> jsons) async {
    return jsons
        .cast<Map<String, dynamic>>()
        .map((Map<String, dynamic> json) => _parseToPost(json))
        .where((Item item) => item != null)
        .toList();
  }

  Item _parseToPost(Map<String, dynamic> json) {
    final String type = json['type'];
    Item item;
    if (type == null)
      item = null;
    else {
      if (compareString(type, 'post'))
        item = PanelDetail.fromJson(json);
      else
        item = Panel.fromJson(json);
    }
    return item;
  }

  @override
  Future<Post> delete(String id) {
    return client.delete('/api/post/$id').then((_) => Post.fromJson(_));
  }

  @override
  Future<Post> edit(PostEditModal postModal) {
    final id = postModal.id;
    final body = postModal.toJson();
    return client.put('/api/post/$id', body);
  }
}
