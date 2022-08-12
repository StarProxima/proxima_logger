// ignore_for_file: avoid_print

import 'log_printer/formatters/log_formatter.dart';
import 'support/log_event.dart';

import 'log_printer/log_printer.dart';
import 'support/log_type.dart';
import 'support/log_output.dart';
export 'support/log_type.dart';

final logger = ProximaLogger(
  settings: LogSettings(
    logTypes: Log.values,
  ),
);

class ProximaLogger {
  ProximaLogger({required this.settings});

  LogSettings settings;

  late final LogPrinter _printer = PrettyPrinter(
    settings,
  );

  final LogOutput _output = ConsoleOutput();

  void log(
    dynamic message, [
    LogType type = Log.info,
    String? title,
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    var logEvent = LogEvent(message, type, title, error, stackTrace);

    var output = _printer.log(logEvent);

    if (output.isNotEmpty) {
      OutputEvent outputEvent = OutputEvent(type, output);
      try {
        _output.output(outputEvent);
      } catch (e, s) {
        print(e);
        print(s);
      }
    }
  }
}

class LogSettings {
  LogSettings({
    required this.logTypes,
    this.printEmoji = true,
    this.printTime = true,
    this.stackTraceMethodCount = 2,
    this.errorStackTraceMethodCount = 8,
    this.stackTraceBeginIndex = 2,
    this.lineLength = 120,
    this.defaultIncludeBox = true,
    Map<LogPart, bool> defaultMiddleBorders = const {
      LogPart.title: false,
      LogPart.error: false,
      LogPart.stackTrace: false,
      LogPart.time: false,
    },
    Map<LogType, bool>? includeBox,
    Map<LogType, Map<LogPart, bool>>? middleBorders,
  }) {
    this.defaultMiddleBorders.addAll(defaultMiddleBorders);
    if (middleBorders != null) {
      for (var entry in middleBorders.entries) {
        this.middleBorders[entry.key]!.addAll(entry.value);
      }
    }
  }

  List<LogType> logTypes;
  final int stackTraceBeginIndex;
  final int stackTraceMethodCount;
  final int errorStackTraceMethodCount;
  final bool printEmoji;
  final bool printTime;
  final int lineLength;
  final startAppTime = DateTime.now();

  bool defaultIncludeBox = true;

  Map<LogPart, bool> defaultMiddleBorders = {
    LogPart.title: false,
    LogPart.error: false,
    LogPart.stackTrace: false,
    LogPart.time: false,
  };

  late Map<LogType, bool> includeBox = {
    for (var type in logTypes) type: defaultIncludeBox
  };

  late Map<LogType, Map<LogPart, bool>> middleBorders = {
    for (var type in logTypes) type: defaultMiddleBorders,
  };
}
