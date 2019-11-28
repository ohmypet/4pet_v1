library petisland_core.constant;

import 'package:flutter/foundation.dart';

abstract class PetIslandConstants {
  static const String key_token = 'token';
}

enum Role { Free, Premium }

enum AccountStatus { Active, Deactive }

enum PostStatus { Pending, New, Done, Expired }

enum PetType { Dog, Cat, Bird, Fish, Snake, Hare, Hamster, Other }

const int max_image = 10;

String enumToString(Object object) {
  return describeEnum(object);
}
