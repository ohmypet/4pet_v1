part of petisland_core.utils;

abstract class PetIslandConstants {
  static const String key_token = 'token';
  static const int max_retry = 5;

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
    MapEntry('chim', PetType.Cat),
    MapEntry('ca', PetType.Fish),
    MapEntry('chuot', PetType.Hamster),
    MapEntry('ran', PetType.Snake),
  ];

  static final Map<CategoryTypeEnum, String> _categoryMap = {
    CategoryTypeEnum.Trending: 'Thịnh hành nhất hiện nay',
    CategoryTypeEnum.Popularity: 'Phổ biến nhất',
    CategoryTypeEnum.PriceLowToHigh: 'Giá từ thấp đến cao',
    CategoryTypeEnum.PriceHighToLow: 'Giá từ cao tới thấp',
    CategoryTypeEnum.PetCategory: 'Loại thú cưng được yêu thích nhất'
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
    final item = PetIslandConstants._petCategories
        .firstWhere((item) => item.key.contains(petCategory), orElse: () => null);
    return item != null ? item.value : PetType.Other;
  }

  static String getCategoryStringFromType(String type) {
    final CategoryTypeEnum typeEnum = getCategoryType(type);
    return _categoryMap[typeEnum] ?? '';
  }
}

/// **Warning**: must update [PetIslandConstants.categoryTypes] same time
enum CategoryTypeEnum { Trending, Popularity, PriceHighToLow, PriceLowToHigh, PetCategory, Post, Unknow }

enum Role { Free, Premium }

enum AccountStatus { Active, DeActive }

enum PostStatus { Pending, New, Done, Expired }

enum PetType { Dog, Cat, Bird, Fish, Snake, Hare, Hamster, Other }

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
