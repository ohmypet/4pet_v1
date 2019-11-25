part of petisland_core.repository;

abstract class ImageRepository {
  Future<List<PetImage>> upload(List<String> paths);
}

class ImageRepositoryImpl extends ImageRepository {
  final HttpClient client;

  ImageRepositoryImpl(this.client);

  @override
  Future<List<PetImage>> upload(List<String> paths) {
    final Iterable<MapEntry<String, MultipartFile>> files = paths.map(
      (String path) => MapEntry<String, MultipartFile>(
        'images',
        MultipartFile.fromFileSync(
          path,
          filename: basename(path),
        ),
      ),
    );
    final FormData formData = FormData()..files.addAll(files);

    return client
        .post<List<dynamic>>("/api/image", formData)
        .then((List<dynamic> images) => _parseImages(images));
  }

  List<PetImage> _parseImages(List<dynamic> images) {
    return images
        .cast<Map<String, dynamic>>()
        .map((Map<String, dynamic> json) => PetImage.fromJson(json))
        .toList();
  }
}
