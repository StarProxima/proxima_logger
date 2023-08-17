// ignore_for_file: public_member_api_docs
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

/// A function that returns the settings for the logger.
typedef SettingsBuilder = LogSettings Function(ILogType logType);

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
    this.skipStackTraceRegExp,
    this.removeAsynchronousSuspensionFromStackTrace = true,
    this.lineLength = 120,
    this.decorateLogTypeLabel = true,
    this.selectError = true,
    this.leftBorder = true,
    this.bottomBorder = true,
    this.customSettings = const {},
  })  : assert(
          stackTraceMethodCount >= 0,
          'stackTraceMethodCount must be >= 0',
        ),
        assert(
          errorStackTraceMethodCount >= 0,
          'errorStackTraceMethodCount must be >= 0',
        ),
        assert(
          stackTraceBeginIndex >= 0,
          'stackTraceBeginIndex must be >= 0',
        ),
        assert(
          lineLength >= 0,
          'lineLength must be >= 0',
        );

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

  /// Skips a string in the trace stack if they satisfy the regular expression.
  final String? skipStackTraceRegExp;

  /// Whether to remove <asynchronous suspension> from the stack trace.
  final bool removeAsynchronousSuspensionFromStackTrace;

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

  /// Custom settings.
  final Map<String, Object> customSettings;
}
