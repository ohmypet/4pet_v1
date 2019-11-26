part of petisland_core.repository;

abstract class PostRepository {
  Future<Post> create(PostModal postModal);
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
}
