library petisland_core.constant;

import 'package:flutter/foundation.dart';

abstract class PetIslandConstants {
  static const String key_token = 'token';

  /// **Warning**: must update [CategoryTypeEnum] same time
  static const List<String> categoryTypes = const <String>[
    'Trending',
    'Popularity',
    'Price higth to low',
    'Price low to hight',
    'Pet category',
    'Post',
  ];
}

/// **Warning**: must update [PetIslandConstants.categoryTypes] same time
enum CategoryTypeEnum {
  Trending,
  Popularity,
  PriceHighToLow,
  PriceLowToHigh,
  PetCategory,
  Post,
}

enum Role { Free, Premium }

enum AccountStatus { Active, DeActive }

enum PostStatus { Pending, New, Done, Expired }

enum PetType { Dog, Cat, Bird, Fish, Snake, Hare, Hamster, Other }

const int max_image = 10;

String enumToString(Object object) {
  if (object is CategoryTypeEnum) return PetIslandConstants.categoryTypes[object.index];

  return describeEnum(object);
}
