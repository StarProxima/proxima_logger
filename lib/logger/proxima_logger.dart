// ignore_for_file: avoid_print

import 'log_decorator/log_decorator.dart';
import 'log_formatter/log_formatter.dart';
import 'support/log_decorations.dart';
import 'support/log_event.dart';

import 'support/formatted_log_event.dart';
import 'support/log_settings.dart';
import 'support/log_type.dart';
import 'support/log_output.dart';
export 'support/log_type.dart';

final logger = ProximaLogger(
  settings: LogSettings(
    logParts: [
      LogPart.stack,
      LogPart.error,
      LogPart.time,
      LogPart.divider,
      LogPart.message,
    ],
    logDecorations: LogDecorations.thick(120),
  ),
  typeSettings: {
    Log.warning: LogSettings(
      leftBorder: true,
      bottomBorder: true,
      printEmoji: false,
      selectError: false,
    ),
  },
);

class ProximaLogger {
  ProximaLogger({
    LogSettings? settings,
    Map<LogType, LogSettings>? typeSettings,
  }) {
    this.settings = settings ?? LogSettings();
    this.typeSettings = typeSettings ?? {};
  }

  late LogSettings settings;

  late Map<LogType, LogSettings> typeSettings;

  late final LogTypeSettings logTypeSettings =
      LogTypeSettings(settings, typeSettings);

  late final Formatter _formatter = LogFormatter(logTypeSettings);

  late final LogDecorator _decorator = LogDecorator(logTypeSettings);

  final LogOutput _output = ConsoleOutput();

  void log(
    LogType log, {
    String? title,
    dynamic error,
    StackTrace? stack,
    dynamic message,
  }) {
    var logEvent = LogEvent(
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
