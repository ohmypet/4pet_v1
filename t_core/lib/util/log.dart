import 'package:flutter/foundation.dart';

class Log {
  static void debug(dynamic data) {
    printConsole("Log:: debug: $data");
  }

  static void info(dynamic data) {
    printConsole("Log:: info: $data");
  }

  static void error(dynamic data) {
    printConsole("Log:: error: $data");
  }

  static void printConsole(dynamic data) {
    if (!kReleaseMode) {
      debugPrint(data);
    }
  }
}
