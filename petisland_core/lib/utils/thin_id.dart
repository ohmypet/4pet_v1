part of petisland_core.utils;

abstract class ThinId {
  static final Random _random = Random();

  static String randomId({int numberCharacter = 25}) {
    StringBuffer str = StringBuffer();
    // _writeToday(str);
    _writeId(str, numberCharacter ?? 25);
    return str.toString();
  }

  static String randomIdWithDayAsPrefix({int numberCharacter = 25}) {
    StringBuffer str = StringBuffer();
    _writeToday(str);
    _writeId(str, numberCharacter ?? 25);
    return str.toString();
  }

  static void _writeToday(StringBuffer str) {
    final DateTime now = DateTime.now();
    final String time = 'tvc_${now.day}_${now.month}_${now.year}_';
    str.write(time);
  }

  static void _writeId(StringBuffer str, int numberCharacter) {
    const String chars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_";
    for (int i = 0; i < numberCharacter; ++i) {
      final String char = chars[_random.nextInt(chars.length)];
      str.write(char);
    }
  }
}
