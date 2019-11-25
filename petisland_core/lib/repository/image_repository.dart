part of petisland_core.repository;

abstract class ImageRepository {
  Future<List<PetImage>> upload(List<String> paths);
}

class ImageRepositoryImpl extends ImageRepository {
  final HttpClient client;

  ImageRepositoryImpl(this.client);

  @override
  Future<List<PetImage>> upload(List<String> paths) {
    final FormData formData = FormData.fromMap(<String, dynamic>{
      'images': paths
          .map((String path) => MultipartFile.fromFileSync(path, filename: basename(path)))
          .toList()
    });
    return client
        .post<List<dynamic>>("/api/image", formData)
        .then((List<dynamic> images) => parseImages(images));
  }
}
