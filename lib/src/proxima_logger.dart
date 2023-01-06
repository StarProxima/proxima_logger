import 'package:proxima_logger/src/support/output_event.dart';

import 'log_decorator/log_decorator.dart';
import 'log_formatter/log_formatter.dart';
import 'support/log_event.dart';

import 'support/formatted_log_event.dart';
import 'support/log_settings.dart';
import 'support/log_type.dart';
import 'support/log_output.dart';
export 'support/log_type.dart';

/// Use instances of ProximaLogger to print log messages.
class ProximaLogger {
  late final LogFormatter _formatter;
  late final LogDecorator _decorator;
  late final LogOutput _output;

  ProximaLogger({
    LogSettings? settings,
    Map<LogType, LogSettings>? typeSettings,
    LogFormatter? formatter,
    LogDecorator? decorator,
    LogOutput? output,
  }) {
    final logTypeSettings = LogTypeSettings(
      settings ?? const LogSettings(),
      typeSettings ?? const {},
    );

    _formatter = formatter ?? DefaultLogFormatter(logTypeSettings);
    _decorator = decorator ?? DefaultLogDecorator(logTypeSettings);
    _output = output ?? ConsoleOutput();
  }

  /// Prints a log message.
  void log(
    LogType log, {
    String? title,
    dynamic error,
    StackTrace? stack,
    dynamic message,
  }) {
    final logEvent = LogEvent(
      log,
      title: title,
      error: error,
      stack: stack,
      message: message,
    );

    FormattedLogEvent formattedLogEvent = _formatter.format(logEvent);

    List<String> lines = _decorator.format(formattedLogEvent);

    OutputEvent outputEvent = OutputEvent(
      type: log,
      logEvent: logEvent,
      formattedLogEvent: formattedLogEvent,
      lines: lines,
    );

    try {
      _output.output(outputEvent);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
}
