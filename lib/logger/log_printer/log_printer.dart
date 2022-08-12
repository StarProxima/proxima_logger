import 'dart:convert';

import '../support/log_event.dart';
import '../support/log_settings.dart';
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

  LogTypeSettings settings;

  late StackTraceFormatter stackTraceFormatter = StackTraceFormatter(settings);
  late LogFormatter logFormatter = LogFormatter(settings);

  late LogTimeFormatter logTimeFormatter = LogTimeFormatter(DateTime.now());

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
    String? errorStr = event.error?.toString();

    String? stackTraceStr;

    if (event.stack == null) {
      if (settings[event.log].stackTraceMethodCount > 0) {
        stackTraceStr = stackTraceFormatter.format(
          event.log,
          StackTrace.current,
          isError: false,
        );
      }
    } else if (settings[event.log].errorStackTraceMethodCount > 0) {
      stackTraceStr = stackTraceFormatter.format(
        event.log,
        event.stack,
        isError: true,
      );
    }

    String? timeStr;

    if (settings[event.log].printTime) {
      timeStr = logTimeFormatter.getLogTime(event.log);
    }

    String? messageStr;

    if (event.message != null) {
      messageStr = stringifyMessage(event.message);
    }

    return logFormatter.format(
      event.log,
      title: event.title,
      error: errorStr,
      stacktrace: stackTraceStr,
      time: timeStr,
      message: messageStr,
    );
  }
}
