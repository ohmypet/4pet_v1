part of petisland_core.service;

abstract class PostService {
  Future<Post> create(PostModal postModal);
  Future<Post> like(String id);
}

class PostServiceImpl extends PostService {
  final PostRepository repository;

  PostServiceImpl(this.repository);

  @override
  Future<Post> create(PostModal postModal) {
    return repository.create(postModal);
  }

  @override
  Future<Post> like(String id) {
    return repository.like(id);
  }
}
