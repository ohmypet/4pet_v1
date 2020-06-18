part of petisland_core.utils;

abstract class PetIslandConstants {
  static const String key_token = 'token';
  static const int max_retry = 5;
  static const Duration time_delay_retry = const Duration(seconds: 1);

  /// **Warning**: must update [CategoryTypeEnum] same time
  static final List<String> categoryTypes = <String>[
    'Trending',
    'Popularity',
    'Price high to low',
    'Price low to high',
    'Pet category',
    'Post',
  ];

  static final List<MapEntry<String, PetType>> _petCategories = [
    MapEntry('meo', PetType.Cat),
    MapEntry('cho', PetType.Dog),
    MapEntry('chim', PetType.Bird),
    MapEntry('ca', PetType.Fish),
    MapEntry('chuot', PetType.Hamster),
    MapEntry('ran', PetType.Snake),
  ];

  static final Map<CategoryTypeEnum, String> _categoryMap = {
    CategoryTypeEnum.Trending: 'Top Trending',
    CategoryTypeEnum.Popularity: 'Top Population',
    CategoryTypeEnum.PriceLowToHigh: 'Price Low To High',
    CategoryTypeEnum.PriceHighToLow: 'Price High To Low',
    CategoryTypeEnum.PetCategory: 'Favorite Category Pet'
  };

  static CategoryTypeEnum getCategoryType(String type) {
    type = type.toLowerCase();
    if (type == 'trending') return CategoryTypeEnum.Trending;
    if (type == 'popularity') return CategoryTypeEnum.Popularity;
    if (type == 'price high to low') return CategoryTypeEnum.PriceHighToLow;
    if (type == 'price low to high') return CategoryTypeEnum.PriceLowToHigh;
    if (type == 'pet category') return CategoryTypeEnum.PetCategory;
    if (type == 'post') return CategoryTypeEnum.Post;
    return CategoryTypeEnum.Unknow;
  }

  static PetType getPetType(String type) {
    final String petCategory = StringUtils.normalizePetCategory(type);
    if (petCategory is String) {
      final item = PetIslandConstants._petCategories
          .firstWhere((item) => petCategory.contains(item.key), orElse: () => null);
      return item != null ? item.value : PetType.Other;
    } else {
      return PetType.Other;
    }
  }

  static String getCategoryStringFromType(String type) {
    final CategoryTypeEnum typeEnum = getCategoryType(type);
    return _categoryMap[typeEnum] ?? '';
  }
}

/// **Warning**: must update [PetIslandConstants.categoryTypes] same time
enum CategoryTypeEnum {
  Trending,
  Popularity,
  PriceHighToLow,
  PriceLowToHigh,
  PetCategory,
  Post,
  Unknow
}

enum Role { Free, Admin, Premium }

enum AccountStatus { Active, DeActive }

enum PostStatus { Pending, New, Done, Expired }

enum PetType { Dog, Cat, Bird, Fish, Snake, Hare, Hamster, Other }

enum RescueStatus { Open, Ready, Success, Failure }

enum RescueAccountStatus { Joined, Blocked }

const int max_image = 10;

String enumToString(Object object) {
  if (object is CategoryTypeEnum) return PetIslandConstants.categoryTypes[object.index];

  return describeEnum(object);
}

bool compareString(String a, String b) {
  if (a == null || b == null) return false;

  a = a.toLowerCase();
  b = b.toLowerCase();
  return a == b;
}
