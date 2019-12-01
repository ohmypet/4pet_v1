part of petisland_core.service;

abstract class TagService {
  Future<List<Tag>> getTags(final String title);
}

class TagServiceImpl extends TagService {
  final TagRepository repository;

  TagServiceImpl(this.repository);

  @override
  Future<List<Tag>> getTags(String title) {
    return repository.getTags(title);
  }
}
