// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'log_decorations.dart';
import 'log_type.dart';

enum LogPart {
  error,
  stack,
  time,
  message,
  divider,
}

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
    this.logParts = const [
      LogPart.stack,
      LogPart.error,
      LogPart.time,
      LogPart.divider,
      LogPart.message,
    ],
    LogDecorations? logDecorations,
    this.printEmoji = true,
    this.printLogTypeLabel = true,
    this.printTitle = true,
    this.printDateInTime = true,
    this.printTimeSinceStartInTime = true,
    this.stackTraceMethodCount = 2,
    this.errorStackTraceMethodCount = 8,
    this.stackTraceBeginIndex = 2,
    this.lineLength = 120,
    this.decorateLogTypeLabel = true,
    this.selectError = true,
    this.leftBorder = true,
    this.bottomBorder = true,
  }) {
    this.logDecorations = logDecorations ?? LogDecorations(lineLength);
  }

  late final LogDecorations logDecorations;

  final List<LogPart> logParts;

  final bool printEmoji;
  final bool printLogTypeLabel;
  final bool printTitle;

  final bool printDateInTime;
  final bool printTimeSinceStartInTime;

  final int stackTraceBeginIndex;
  final int stackTraceMethodCount;
  final int errorStackTraceMethodCount;
  final int lineLength;

  final bool decorateLogTypeLabel;
  final bool selectError;

  final bool leftBorder;
  final bool bottomBorder;
}
