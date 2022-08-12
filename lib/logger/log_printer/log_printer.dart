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
  PrettyPrinter(
    this.settings,
  );

  LogSettings settings;

  late StackTraceFormatter stackTraceFormatter = StackTraceFormatter(settings);

  late LogTimeFormatter logTimeFormatter = LogTimeFormatter(settings);

  late LogFormatter logFormatter = LogFormatter(settings);

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
      if (settings.stackTraceMethodCount > 0) {
        stackTraceStr = stackTraceFormatter.format(
          StackTrace.current,
          isError: false,
        );
      }
    } else if (settings.errorStackTraceMethodCount > 0) {
      stackTraceStr = stackTraceFormatter.format(
        event.stackTrace,
        isError: true,
      );
    }

    String? timeStr;
    if (settings.printTime) {
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
