part of petisland_core.service;

class TCacheService extends BaseCacheManager {
  final Directory dictionary;
  final String key;
  TCacheService(
    this.key,
    this.dictionary, {
    Duration maxAgeCacheObject = const Duration(days: 30),
    int maxNrOfCacheObjects = 200,
    FileService fileService,
  }) : super(
          key,
          maxAgeCacheObject: maxAgeCacheObject,
          maxNrOfCacheObjects: maxNrOfCacheObjects,
          fileService: fileService,
        );

  @override
  Future<String> getFilePath() async {
    return path.join(dictionary.path, key);
  }
}
