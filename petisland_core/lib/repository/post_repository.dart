part of petisland_core.repository;

abstract class PostRepository {
  Future<Post> create(PostModal postModal);

  Future<Post> like(String id);
}

class PostRepositoryImpl extends PostRepository {
  final HttpClient client;

  PostRepositoryImpl(this.client);

  @override
  Future<Post> create(PostModal postModal) {
    return client
        .post<Map<String, dynamic>>('/api/post', postModal.toJson())
        .then((Map<String, dynamic> json) => Post.fromJson(json));
  }

  @override
  Future<Post> like(String id) {
    return client
        .get<Map<String, dynamic>>("/api/post/$id/like")
        .then((Map<String, dynamic> json) => Post.fromJson(json));
  }
}
