part of petisland_core.utils;

abstract class StringUtils {
  static String normalizePetCategory(String petCategory) {
    return tiengviet(petCategory)?.toLowerCase()?.trim();
  }
}
