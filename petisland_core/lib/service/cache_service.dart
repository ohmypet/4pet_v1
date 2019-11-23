part of petisland_core.service;

class TCacheService extends BaseCacheManager {
  final Directory dictionary;
  final String key;
  TCacheService(
    this.key,
    this.dictionary, {
    Duration maxAgeCacheObject = const Duration(days: 30),
    int maxNrOfCacheObjects = 200,
    FileFetcher fileFetcher,
  }) : super(
          key,
          maxAgeCacheObject: maxAgeCacheObject,
          maxNrOfCacheObjects: maxNrOfCacheObjects,
          fileFetcher: fileFetcher,
        );

  @override
  Future<String> getFilePath() async {
    return path.join(dictionary.path, key);
  }
}
