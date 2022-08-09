import 'dart:convert';

import '../proxima_logger.dart';
import 'log_formatter.dart';
import 'stack_trace_formatter.dart';
import 'time_formatter.dart';

abstract class LogPrinter {
  void init() {}

  List<String> log(LogEvent event);

  void destroy() {}
}

class PrettyPrinter extends LogPrinter {
  PrettyPrinter({
    this.stackTraceBeginIndex = 0,
    this.methodCount = 2,
    this.errorMethodCount = 3,
    this.printTime = true,
    this.printEmojis = true,
  });

  static final DateTime _startTime = DateTime.now();

  late LogTimeFormatter logTimeFormatter = LogTimeFormatter(
    _startTime,
  );

  late StackTraceFormatter stackTraceFormatter = StackTraceFormatter(
    stackTraceBeginIndex,
  );

  LogFormatter logFormatter = LogFormatter();

  final int stackTraceBeginIndex;
  final int methodCount;
  final int errorMethodCount;
  final bool printEmojis;
  final bool printTime;
  @override
  List<String> log(LogEvent event) {
    var messageStr = stringifyMessage(event.message);

    String? stackTraceStr;
    if (event.stackTrace == null) {
      if (methodCount > 0) {
        stackTraceStr = stackTraceFormatter.format(
          StackTrace.current,
          methodCount,
        );
      }
    } else if (errorMethodCount > 0) {
      stackTraceStr = stackTraceFormatter.format(
        event.stackTrace,
        errorMethodCount,
      );
    }

    String? errorStr = event.error?.toString();

    String? timeStr;
    if (printTime) {
      timeStr = logTimeFormatter.getLogTime();
    }

    return logFormatter.format(
      event.level,
      messageStr,
      timeStr,
      errorStr,
      stackTraceStr,
    );
  }

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
}
