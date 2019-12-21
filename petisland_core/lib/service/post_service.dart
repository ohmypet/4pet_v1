part of petisland_core.service;

abstract class PostService {
  Future<Post> create(PostModal postModal);

  Future<Post> like(String id);

  Future<List<Item>> getPosts(int offset,
      {int limit = 10, String categoryType, String petCategoryId});

  Future<Post> delete(String id);
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

  @override
  Future<List<Item>> getPosts(int offset,
      {int limit = 10, String categoryType, String petCategoryId}) {
    return repository.getPosts(offset, limit ?? 10, categoryType, petCategoryId);
  }

  @override
  Future<Post> delete(String id) {
    return repository.delete(id);
  }
}
