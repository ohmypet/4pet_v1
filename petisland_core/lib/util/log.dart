//ignore_for_file: avoid_print
library petisland_core.log;

import 'package:ansicolor/ansicolor.dart';

abstract class Log {
  static final _debugCode = chooseLogColor(LogLevel.DEBUG);
  static final _infoCode = chooseLogColor(LogLevel.INFO);
  static final _errorCode = chooseLogColor(LogLevel.ERROR);

  static void debug(dynamic data) {
    _print(_debugCode, 'log_debug:: $data');
  }

  static void info(dynamic data) {
    _print(_infoCode, 'log_info:: $data');
  }

  static void error(dynamic data) {
    _print(_errorCode, 'log_error:: $data');
  }

  static void _print(AnsiPen code, dynamic data) {
    print(code(data));
  }
}

enum LogLevel {
  DEBUG,
  INFO,
  WARN,
  ERROR,
  ALL,
}

/// Chooses a color based on the logger [level].
AnsiPen chooseLogColor(LogLevel level) {
  switch (level) {
    case LogLevel.ALL:
      return AnsiPen()..white();
    case LogLevel.DEBUG:
      return AnsiPen()..white();
    case LogLevel.INFO:
      return AnsiPen()..blue();
    case LogLevel.ERROR:
      return AnsiPen()..red();
    default:
      return AnsiPen()..white();
  }
}
