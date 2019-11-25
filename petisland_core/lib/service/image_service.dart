part of petisland_core.service;

abstract class ImageService {
  Future<PetImage> upload(List<String> paths);
}

