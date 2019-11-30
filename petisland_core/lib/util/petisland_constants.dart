library petisland_core.constant;

import 'package:flutter/foundation.dart';

abstract class PetIslandConstants {
  static const String key_token = 'token';

  static const List<String> categories = <String>[
    'Trending',
    'Popularity',
    'Price higth to low',
    'Price low to hight',
    'Pet category',
  ];
}

enum CategoryEnum {
  Trending,
  Popularity,
  PriceHighToLow,
  PriceLowToHight,
  PetCategory,
}

enum Role { Free, Premium }

enum AccountStatus { Active, Deactive }

enum PostStatus { Pending, New, Done, Expired }

enum PetType { Dog, Cat, Bird, Fish, Snake, Hare, Hamster, Other }

const int max_image = 10;

String enumToString(Object object) {
  if (object is CategoryEnum) return PetIslandConstants.categories[object.index];

  return describeEnum(object);
}
