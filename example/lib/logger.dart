// ignore_for_file: avoid_redundant_argument_values

import 'package:dio/dio.dart';
import 'package:proxima_logger/proxima_logger.dart';

final logger = MyLogger(
  settings: (logType) => switch (logType) {
    Log.debug => const LogSettings(
        logParts: [
          LogPart.stack,
          LogPart.time,
          LogPart.message,
        ],
        logDecorations: LogDecorations.rounded(),
      ),
    Log.warning => const LogSettings(
        logDecorations: LogDecorations.rounded(),
      ),
    Log.error => const LogSettings(
        logDecorations: LogDecorations.thick(),
      ),
    Log.wtf || Log.nothing => const LogSettings(
        logDecorations: LogDecorations.thin(),
      ),
    _ => const LogSettings(
        logParts: [
          LogPart.stack,
          LogPart.error,
          LogPart.time,
          LogPart.divider,
          LogPart.message,
        ],
        printEmoji: true,
        printTitle: true,
        printLogTypeLabel: true,
      ),
  },
);

class MyLogger extends ProximaLoggerBase {
  MyLogger({
    super.settings,
    super.formatter,
    super.decorator,
    super.output,
  });

  void info(String message) {
    log(Log.info, message: message);
  }

  void error(Error error, StackTrace stack, [String? message]) {
    log(Log.error, error: error, stack: stack, message: message);
  }

  void response(Response response) {
    log(
      Log.response,
      title:
          '| ${response.requestOptions.method} | ${response.statusCode} | ${response.requestOptions.path}',
      message: response.data,
    );
  }
}

enum Log implements ILogType {
  info(
    label: 'info',
    emoji: '💡',
    ansiPen: AnsiPen.none(),
  ),
  debug(
    label: 'debug',
    emoji: '🐛',
    ansiPen: AnsiPen.green(),
  ),
  warning(
    label: 'warning',
    emoji: '⚠️',
    ansiPen: AnsiPen.orange(),
  ),
  error(
    label: 'error',
    emoji: '⛔',
    ansiPen: AnsiPen.red(),
  ),
  wtf(
    label: 'wtf',
    emoji: '👾',
    ansiPen: AnsiPen.purple(),
  ),
  request(
    label: 'request',
    emoji: '📡',
    ansiPen: AnsiPen.blue(),
  ),
  response(
    label: 'response',
    emoji: '📡',
    ansiPen: AnsiPen.blue(),
  ),
  nothing(
    label: '',
    emoji: '',
    ansiPen: AnsiPen.none(),
  );

  const Log({
    required this.label,
    required this.emoji,
    required this.ansiPen,
    // ignore: unused_element
    this.ansiPenOnBackground = const AnsiPen.black(),
  });

  @override
  final String label;
  @override
  final String emoji;
  @override
  final AnsiPen ansiPen;
  @override
  final AnsiPen ansiPenOnBackground;
}
