part of petisland_core.service;

abstract class PetCategoryService {
  Future<List<PetCategory>> getPetCategories();
}

class PetCategoryServiceImpl extends PetCategoryService {
  final PetCategoryRepository repository;

  PetCategoryServiceImpl(this.repository);

  @override
  Future<List<PetCategory>> getPetCategories() {
    return repository.getPetCategories();
  }
}
