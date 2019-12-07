part of petisland_core.service;

abstract class ImageService {
  Future<List<PetImage>> upload(List<String> paths);
}

class ImageServiceImpl extends ImageService {
  final ImageRepository repository;

  ImageServiceImpl(this.repository);

  @override
  Future<List<PetImage>> upload(List<String> paths) {
    return repository.upload(paths);
  }
}
