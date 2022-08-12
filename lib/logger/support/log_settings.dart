// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    this.printLogTypeLabel = true,
    this.printTitle = true,
    this.printMessage = true,
    this.printStack = false,
    this.printError = true,
    this.printTime = true,
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
    this.dividerOverError = false,
    this.dividerOverStack = false,
    this.dividerOverTime = false,
    this.dividerOverMessage = true,
  }) {
    this.logDecorations = logDecorations ?? LogDecorations(lineLength);
  }

  late final LogDecorations logDecorations;

  final bool printEmoji;
  final bool printLogTypeLabel;
  final bool printTitle;

  final bool printStack;
  final bool printError;
  final bool printMessage;

  final bool printTime;
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

  final bool dividerOverError;
  final bool dividerOverStack;
  final bool dividerOverTime;
  final bool dividerOverMessage;

  LogSettings copyWith({
    LogDecorations? logDecorations,
    bool? printEmoji,
    bool? printLogTypeLabel,
    bool? printTitle,
    bool? printStack,
    bool? printError,
    bool? printMessage,
    bool? printTime,
    bool? printDateInTime,
    bool? printTimeSinceStartInTime,
    int? stackTraceBeginIndex,
    int? stackTraceMethodCount,
    int? errorStackTraceMethodCount,
    int? lineLength,
    bool? decorateLogTypeLabel,
    bool? selectError,
    bool? leftBorder,
    bool? bottomBorder,
    bool? dividerOverError,
    bool? dividerOverStack,
    bool? dividerOverTime,
    bool? dividerOverMessage,
  }) {
    return LogSettings(
      logDecorations: logDecorations ?? this.logDecorations,
      printEmoji: printEmoji ?? this.printEmoji,
      printLogTypeLabel: printLogTypeLabel ?? this.printLogTypeLabel,
      printTitle: printTitle ?? this.printTitle,
      printStack: printStack ?? this.printStack,
      printError: printError ?? this.printError,
      printMessage: printMessage ?? this.printMessage,
      printTime: printTime ?? this.printTime,
      printDateInTime: printDateInTime ?? this.printDateInTime,
      printTimeSinceStartInTime:
          printTimeSinceStartInTime ?? this.printTimeSinceStartInTime,
      stackTraceBeginIndex: stackTraceBeginIndex ?? this.stackTraceBeginIndex,
      stackTraceMethodCount:
          stackTraceMethodCount ?? this.stackTraceMethodCount,
      errorStackTraceMethodCount:
          errorStackTraceMethodCount ?? this.errorStackTraceMethodCount,
      lineLength: lineLength ?? this.lineLength,
      decorateLogTypeLabel: decorateLogTypeLabel ?? this.decorateLogTypeLabel,
      selectError: selectError ?? this.selectError,
      leftBorder: leftBorder ?? this.leftBorder,
      bottomBorder: bottomBorder ?? this.bottomBorder,
      dividerOverError: dividerOverError ?? this.dividerOverError,
      dividerOverStack: dividerOverStack ?? this.dividerOverStack,
      dividerOverTime: dividerOverTime ?? this.dividerOverTime,
      dividerOverMessage: dividerOverMessage ?? this.dividerOverMessage,
    );
  }
}
