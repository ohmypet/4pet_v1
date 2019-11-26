library petisland_core.log;

import 'package:flutter/foundation.dart';
class Log {
  static void debug(dynamic data) {
    printConsole("Log_debug: $data");
  }

  static void info(dynamic data) {
    printConsole("Log_info: $data");
  }

  static void error(dynamic data) {
    printConsole("Log_error: $data");
  }

  static void printConsole(dynamic data) {
    if (!kReleaseMode) {
      debugPrint(data);
    }
  }
}
