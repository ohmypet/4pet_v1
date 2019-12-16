library petisland_core.time;

import 'package:timeago/timeago.dart' as timeAgo;

class TViShortMessage extends timeAgo.ViShortMessages {
  String suffixAgo() => 'trước';
}

abstract class TimeUtils {
  static String getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final Duration diff = now.difference(time);

    return timeAgo.format(now.subtract(diff), locale: 'vi');
  }
}
