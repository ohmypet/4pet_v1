part of petisland_core.repository;

abstract class PetCategoryRepository {
  Future<List<PetCategory>> getPetCategories();
}

class PetCategoryRepositoryImpl extends PetCategoryRepository {
  final HttpClient client;

  PetCategoryRepositoryImpl(this.client);

  @override
  Future<List<PetCategory>> getPetCategories() {
    return client
        .get<List<dynamic>>('/api/pet-category')
        .then((List<dynamic> json) => _parseToPetCategory(json));
  }

  List<PetCategory> _parseToPetCategory(List<dynamic> categories) {
    return categories
        .cast<Map<String, dynamic>>()
        .map((Map<String, dynamic> json) => PetCategory.fromJson(json));
  }
}
