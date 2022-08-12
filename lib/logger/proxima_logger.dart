// ignore_for_file: avoid_print

import 'support/log_decorations.dart';
import 'support/log_event.dart';

import 'log_printer/log_printer.dart';
import 'support/log_settings.dart';
import 'support/log_type.dart';
import 'support/log_output.dart';
export 'support/log_type.dart';

final logger = ProximaLogger(
  settings: LogSettings(
    logDecorations: LogDecorations.rounded(120),
  ),
  logTypeSettings: {
    Log.warning: LogSettings(
      leftBorder: true,
      bottomBorder: true,
      printEmoji: false,
      selectError: false,
      dividerOverError: true,
      dividerOverMessage: true,
      dividerOverStack: true,
      dividerOverTime: true,
    ),
  },
);

class ProximaLogger {
  ProximaLogger({required this.settings, this.logTypeSettings});

  LogSettings settings;

  Map<LogType, LogSettings>? logTypeSettings;

  late final LogPrinter _printer = PrettyPrinter(
    LogTypeSettings(settings, logTypeSettings ?? {}),
  );

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

    var output = _printer.log(logEvent);

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
