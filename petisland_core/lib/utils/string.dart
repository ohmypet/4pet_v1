part of petisland_core.utils;

abstract class StringUtils {
  final Pattern pattern = RegExp(r'@{(.+)}');

  static String normalizePetCategory(String petCategory) {
    return tiengviet(petCategory)?.toLowerCase()?.trim();
  }

  static bool isImageUrlFormat(String url) {
    return url.contains(RegExp('^https?://')) ||
        url.contains(RegExp('^http?://'));
  }

  static List<TextConfig> getTextConfigs(String text) {
    if (text == null) return [];
    text = text.trim();
    final List<String> texts = text.split('@{');
    final List<TextConfig> textConfigs = texts
        .where((item) => item?.isNotEmpty)
        .fold<List<TextConfig>>([], (List<TextConfig> list, String word) {
      final index = word.indexOf('}');
      if (index > -1) {
        final first = word.substring(0, index)?.trim();
        if (first?.isNotEmpty == true) list.add(TextConfig.notation(first));

        if (index + 1 < word.length) {
          final second = word.substring(index + 1, word.length)?.trim();
          if (second?.isNotEmpty == true) list.add(TextConfig.normal(second));
        }
      } else {
        list.add(TextConfig.normal(word));
      }
      return list;
    });

    return textConfigs;
  }
}

class TextConfig {
  final String text;
  final bool isANotation;

  TextConfig.normal(this.text) : isANotation = false;
  TextConfig.notation(this.text) : isANotation = true;
}
