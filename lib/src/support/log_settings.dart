// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'log_decorations.dart';
import 'log_type.dart';

/// Allows you to set the order in which parts of the log are displayed.
enum LogPart {
  error,
  stack,
  time,
  message,
  divider,
}

class LogTypeSettings {
  final LogSettings settings;
  final Map<LogType, LogSettings> logTypeSettings;

  const LogTypeSettings(this.settings, this.logTypeSettings);

  LogSettings operator [](LogType key) {
    return logTypeSettings[key] ?? settings;
  }
}

/// Settings for the logger.
class LogSettings {
  const LogSettings({
    this.logParts = const [
      LogPart.stack,
      LogPart.error,
      LogPart.time,
      LogPart.divider,
      LogPart.message,
    ],
    this.logDecorations = const LogDecorations.thin(),
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
  });

  /// Wrapping style on output.
  final LogDecorations logDecorations;

  /// Allows you to set the order in which parts of the log are displayed.
  final List<LogPart> logParts;

  /// Whether to print the emoji.
  final bool printEmoji;

  /// Whether to print the log type label.
  final bool printLogTypeLabel;

  /// Whether to print the title.
  final bool printTitle;

  /// Whether to print the date in the time.
  final bool printDateInTime;

  /// Whether to print the time since the start of the app in the time.
  final bool printTimeSinceStartInTime;

  /// The number of methods to print in the stack trace.
  final int stackTraceBeginIndex;

  /// The number of methods to print in the stack trace.
  final int stackTraceMethodCount;

  /// The number of methods to print in the error stack trace.
  final int errorStackTraceMethodCount;

  /// The length of the line.
  final int lineLength;

  /// Whether to decorate the log type label.
  final bool decorateLogTypeLabel;

  /// Whether to select the error.
  final bool selectError;

  /// Whether to print the left border.
  final bool leftBorder;

  /// Whether to print the bottom border.
  final bool bottomBorder;
}
