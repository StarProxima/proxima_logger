import 'dart:convert';

import '../proxima_logger.dart';
import '../support/log_event.dart';
import 'formatters/log_formatter.dart';
import 'formatters/stack_trace_formatter.dart';
import 'formatters/time_formatter.dart';

abstract class LogPrinter {
  void init() {}

  List<String> log(LogEvent event);

  void destroy() {}
}

class PrettyPrinter extends LogPrinter {
  PrettyPrinter({
    required this.logTypes,
    this.stackTraceBeginIndex = 2,
    this.methodCount = 2,
    this.errorMethodCount = 8,
    this.printTime = false,
    this.printEmoji = true,
    this.includeBox,
    this.middleBorders,
  });

  static final DateTime _startTime = DateTime.now();

  LogTimeFormatter logTimeFormatter = LogTimeFormatter(
    _startTime,
  );

  StackTraceFormatter stackTraceFormatter = const StackTraceFormatter();

  late Map<LogTypeInterface, bool> defaultIncludeBox = {
    for (var type in logTypes) type: true
  };

  late Map<LogTypeInterface, Map<LogPart, bool>> defaultMiddleBorders = {
    for (var type in logTypes)
      type: {
        for (var part in LogPart.values) part: false,
      },
  };

  late LogFormatter logFormatter = LogFormatter(
    printEmoji: printEmoji,
    includeBox: includeBox ?? defaultIncludeBox,
    middleBorders: middleBorders ?? defaultMiddleBorders,
  );

  List<LogTypeInterface> logTypes;
  final int stackTraceBeginIndex;
  final int methodCount;
  final int errorMethodCount;
  final bool printEmoji;
  final bool printTime;
  final Map<LogTypeInterface, bool>? includeBox;

  final Map<LogTypeInterface, Map<LogPart, bool>>? middleBorders;

  // Handles any object that is causing JsonEncoder() problems
  Object toEncodableFallback(dynamic object) {
    return object.toString();
  }

  String stringifyMessage(dynamic message) {
    final finalMessage = message is Function ? message() : message;
    if (finalMessage is Map || finalMessage is Iterable) {
      var encoder = JsonEncoder.withIndent('  ', toEncodableFallback);
      return encoder.convert(finalMessage);
    } else {
      return finalMessage.toString();
    }
  }

  @override
  List<String> log(LogEvent event) {
    var messageStr = stringifyMessage(event.message);

    String? stackTraceStr;
    if (event.stackTrace == null) {
      if (methodCount > 0) {
        stackTraceStr = stackTraceFormatter.format(
          StackTrace.current,
          methodCount,
          stackTraceBeginIndex,
        );
      }
    } else if (errorMethodCount > 0) {
      stackTraceStr = stackTraceFormatter.format(
        event.stackTrace,
        errorMethodCount,
      );
    }

    String? timeStr;
    if (printTime) {
      timeStr = logTimeFormatter.getLogTime();
    }

    String? errorStr = event.error?.toString();

    return logFormatter.format(
      messageStr,
      event.type,
      event.title ?? '',
      timeStr,
      errorStr,
      stackTraceStr,
    );
  }
}
