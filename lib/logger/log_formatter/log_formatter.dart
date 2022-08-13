import 'dart:convert';

import '../support/log_event.dart';
import '../support/formatted_log_event.dart';
import '../support/log_settings.dart';
import 'formatters/stack_trace_formatter.dart';
import 'formatters/time_formatter.dart';

abstract class Formatter {
  void init() {}

  FormattedLogEvent log(LogEvent event);

  void destroy() {}
}

class LogFormatter extends Formatter {
  LogFormatter(
    this.settings,
  );

  LogTypeSettings settings;

  late StackTraceFormatter stackTraceFormatter = StackTraceFormatter(settings);

  late LogTimeFormatter logTimeFormatter = LogTimeFormatter(
    settings,
    startAppTime: DateTime.now(),
  );

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
  FormattedLogEvent log(LogEvent event) {
    LogSettings st = settings[event.log];
    String? errorStr = event.error?.toString();

    String? stackTraceStr;

    if (st.logParts.contains(LogPart.stack)) {
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
    }
    String? timeStr;

    if (st.logParts.contains(LogPart.time)) {
      timeStr = logTimeFormatter.getLogTime(event.log);
    }

    String? messageStr;

    if (st.logParts.contains(LogPart.message) && event.message != null) {
      messageStr = stringifyMessage(event.message);
    }

    FormattedLogEvent printLogEvent = FormattedLogEvent(
      event.log,
      title: event.title,
      error: errorStr,
      stack: stackTraceStr,
      time: timeStr,
      message: messageStr,
    );

    return printLogEvent;
  }
}
