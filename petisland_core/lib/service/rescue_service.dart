part of petisland_core.service;

abstract class RescueService {
  Future<Rescue> create(Rescue rescue, List<String> imageIds);
  Future<Rescue> update(Rescue rescue);
  Future<bool> delete(String rescueId);

  Future<List<Comment>> getComments(String id);
  Future<bool> deleteComment(String rescueId, String commentId);

  Future<List<RescueDonate>> getDonaters(String id);

  Future<List<RescueAccount>> getHeroJoined(String id);
  Future<bool> join(String id);

  Future<bool> like(String id);

  Future<List<Rescue>> search({int from = 0, int limit = 10});

  Future<bool> unJoin(String id);

  Future<bool> addComment(String rescueId, String message);
}

class RescueServiceImpl extends RescueService {
  final RescueRepository repository;

  RescueServiceImpl(this.repository);

  @override
  Future<Rescue> create(Rescue rescue, List<String> imageIds) =>
      repository.create(rescue, imageIds);

  @override
  Future<List<Comment>> getComments(String id) {
    return repository.getComments(id);
  }

  @override
  Future<List<RescueDonate>> getDonaters(String id) {
    return repository.getDonaters(id);
  }

  @override
  Future<List<RescueAccount>> getHeroJoined(String id) {
    return repository.getHeroJoined(id);
  }

  @override
  Future<bool> join(String id) => repository.join(id);

  @override
  Future<bool> like(String id) => repository.like(id);

  @override
  Future<List<Rescue>> search({int from = 0, int limit = 10}) =>
      repository.search(from ?? 0, limit ?? 10);

  @override
  Future<bool> unJoin(String id) => repository.unJoin(id);

  @override
  Future<Rescue> update(Rescue rescue) => repository.update(rescue);

  @override
  Future<bool> delete(String rescueId) {
    return repository.delete(rescueId);
  }

  @override
  Future<bool> deleteComment(String rescueId, String commentId) {
    return repository.deleteComment(rescueId, commentId);
  }

  @override
  Future<bool> addComment(String rescueId, String message) {
    return repository.addComment(rescueId, message);
  }
}
