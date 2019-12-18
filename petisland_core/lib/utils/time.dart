part of petisland_core.utils;

class TViShortMessage extends timeAgo.ViMessages {
  // String suffixAgo() => 'trước';
}

abstract class TimeUtils {
  static String getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final Duration diff = now.difference(time);

    return timeAgo.format(now.subtract(diff), locale: 'vi');
  }
}
