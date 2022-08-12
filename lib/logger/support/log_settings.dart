import 'log_decorations.dart';
import 'log_type.dart';

class LogTypeSettings {
  LogTypeSettings(this.settings, this.logTypeSettings);

  final LogSettings settings;

  final Map<LogType, LogSettings> logTypeSettings;

  LogSettings operator [](LogType key) {
    return logTypeSettings[key] ?? settings;
  }
}

class LogSettings {
  LogSettings({
    LogDecorations? logDecorations,
    this.printEmoji = true,
    this.printTime = false,
    this.stackTraceMethodCount = 2,
    this.errorStackTraceMethodCount = 8,
    this.stackTraceBeginIndex = 2,
    this.lineLength = 120,
    this.leftBorder = true,
    this.bottomBorder = true,
    this.decorateLogTypeLabel = true,
    this.selectError = true,
    this.dividerOverError = false,
    this.dividerOverStack = false,
    this.dividerOverTime = false,
    this.dividerOverMessage = true,
  }) {
    this.logDecorations = logDecorations ?? LogDecorations(lineLength);
  }

  late final LogDecorations logDecorations;

  final bool printEmoji;

  final bool printTime;

  final int stackTraceBeginIndex;
  final int stackTraceMethodCount;
  final int errorStackTraceMethodCount;
  final int lineLength;

  final bool decorateLogTypeLabel;
  final bool selectError;

  final bool leftBorder;
  final bool bottomBorder;

  final bool dividerOverError;
  final bool dividerOverStack;
  final bool dividerOverTime;
  final bool dividerOverMessage;
}
