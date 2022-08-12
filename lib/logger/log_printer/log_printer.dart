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
    this.printTime = true,
    this.printEmojis = true,
  });

  static final DateTime _startTime = DateTime.now();

  late LogTimeFormatter logTimeFormatter = LogTimeFormatter(
    _startTime,
  );

  late StackTraceFormatter stackTraceFormatter = const StackTraceFormatter();

  late LogFormatter logFormatter = LogFormatter(
    includeBox: {for (var type in logTypes) type: true},
  );

  List<LogTypeInterface> logTypes;
  final int stackTraceBeginIndex;
  final int methodCount;
  final int errorMethodCount;
  final bool printEmojis;
  final bool printTime;

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

    String titleStr =
        '${printEmojis ? event.type.emoji : ''}[${event.type.label.toUpperCase()}] ${event.title ?? ''}';

    String? timeStr;
    if (printTime) {
      timeStr = logTimeFormatter.getLogTime();
    }

    String? errorStr = event.error?.toString();

    return logFormatter.format(
      messageStr,
      event.type,
      titleStr,
      timeStr,
      errorStr,
      stackTraceStr,
    );
  }
}
