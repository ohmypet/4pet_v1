part of petisland_core.service;

abstract class PostService {
  Future<Post> create(PostCreateModal postModal);

  Future<Post> edit(PostEditModal postModal);

  Future<Post> like(String id);

  Future<List<Item>> getPosts(int offset,
      {int limit = 10, String categoryType, String petCategoryId});

  Future<Post> delete(String id);

  Future<Comment> createComment(String postId, String message);

  Future<List<Comment>> getComments(String postId, {int offset, int limit});

  Future<Comment> deleteComment(String postId, String commentId);

  Future<List<PanelDetail>> getMyPost({int offset, int limit});

  Future<List<PanelDetail>> getPostLiked({int offset, int limit});
}

class PostServiceImpl extends PostService {
  final PostRepository repository;

  PostServiceImpl(this.repository);

  @override
  Future<Post> create(PostCreateModal postModal) {
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

  @override
  Future<Post> edit(PostEditModal postModal) {
    return repository.edit(postModal);
  }

  @override
  Future<Comment> createComment(String postId, String message) {
    return repository.createComment(postId, message);
  }

  @override
  Future<Comment> deleteComment(String postId, String commentId) {
    return repository.deleteComment(postId, commentId);
  }

  @override
  Future<List<Comment>> getComments(String postId, {int offset = 0, int limit = 15}) {
    return repository.getComments(postId, offset: offset, limit: limit);
  }

  @override
  Future<List<PanelDetail>> getMyPost({int offset, int limit}) {
    return repository.getMyPost(offset: offset, limit: limit);
  }

  @override
  Future<List<PanelDetail>> getPostLiked({int offset, int limit}) {
    return repository.getPostLiked(offset: offset, limit: limit);
  }
}
