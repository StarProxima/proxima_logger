import 'support/output_event.dart';

import 'log_decorator/log_decorator.dart';
import 'log_formatter/log_formatter.dart';
import 'support/log_event.dart';

import 'support/log_settings.dart';
import 'support/log_type.dart';
import 'support/log_output.dart';
export 'support/log_type.dart';

abstract class ProximaLoggerBase {
  ProximaLoggerBase({
    SettingsBuilder? settings,
    ILogFormatter? formatter,
    ILogDecorator? decorator,
    ILogOutput? output,
  }) {
    final settingsBuilder = settings ?? (_) => LogSettings();

    _formatter = formatter ?? LogFormatter(settingsBuilder);
    _decorator = decorator ?? LogDecorator(settingsBuilder);
    _output = output ?? ConsoleOutput();
  }

  late final ILogFormatter _formatter;
  late final ILogDecorator _decorator;
  late final ILogOutput _output;

  /// Prints a log message.
  void log(
    ILogType type, {
    String? title,
    dynamic error,
    StackTrace? stack,
    dynamic message,
  }) {
    final logEvent = LogEvent(
      type,
      title: title,
      error: error,
      stack: stack,
      message: message,
      time: DateTime.now(),
    );

    logFromEvent(logEvent);
  }

  void logFromEvent(LogEvent logEvent) {
    try {
      final formattedLogEvent = _formatter.format(logEvent);

      final lines = _decorator.decorate(formattedLogEvent);

      final outputEvent = OutputEvent(
        type: logEvent.type,
        logEvent: logEvent,
        formattedLogEvent: formattedLogEvent,
        lines: lines,
      );

      _output.output(outputEvent);
    } catch (e, s) {
      // ignore: avoid_print
      print(e);
      // ignore: avoid_print
      print(s);
    }
  }
}
