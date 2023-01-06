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
  ProximaLogger({
    LogSettings? settings,
    Map<LogType, LogSettings>? typeSettings,
  }) {
    this.settings = settings ?? LogSettings();
    this.typeSettings = typeSettings ?? {};
  }

  /// The default settings for all log types.
  late LogSettings settings;

  /// The settings for each log type.
  late Map<LogType, LogSettings> typeSettings;

  late final LogTypeSettings logTypeSettings =
      LogTypeSettings(settings, typeSettings);

  late final Formatter _formatter = LogFormatter(logTypeSettings);

  late final LogDecorator _decorator = LogDecorator(logTypeSettings);

  final LogOutput _output = ConsoleOutput();

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

    List<String> output = _decorator.format(formattedLogEvent);

    if (output.isNotEmpty) {
      OutputEvent outputEvent = OutputEvent(log, output);
      try {
        _output.output(outputEvent);
      } catch (e, s) {
        print(e);
        print(s);
      }
    }
  }
}
