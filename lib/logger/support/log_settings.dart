import 'log_type.dart';

class LogSettings {
  LogSettings({
    this.printEmoji = true,
    this.printTime = false,
    this.stackTraceMethodCount = 2,
    this.errorStackTraceMethodCount = 8,
    this.stackTraceBeginIndex = 2,
    this.bottomBorderLength = 120,
    this.leftBorder = true,
    this.bottomBorder = true,
    this.decorateLogTypeLabel = true,
    this.selectError = true,
    this.dividerOverError = false,
    this.dividerOverStack = false,
    this.dividerOverTime = false,
    this.dividerOverMessage = true,
  }) {
    const doubleDivider = '─';
    const singleDivider = '┄';
    var doubleDividerLine = StringBuffer();
    var singleDividerLine = StringBuffer();
    for (var i = 0; i < bottomBorderLength - 1; i++) {
      doubleDividerLine.write(doubleDivider);
      singleDividerLine.write(singleDivider);
    }
    this.doubleDividerLine = '$doubleDividerLine';
    this.singleDividerLine = '$singleDividerLine';
  }

  final bool printEmoji;
  final bool printTime;

  final int stackTraceBeginIndex;
  final int stackTraceMethodCount;
  final int errorStackTraceMethodCount;
  final int bottomBorderLength;

  final bool decorateLogTypeLabel;
  final bool selectError;

  final bool leftBorder;
  final bool bottomBorder;

  final bool dividerOverError;
  final bool dividerOverStack;
  final bool dividerOverTime;
  final bool dividerOverMessage;

  late final String doubleDividerLine;
  late final String singleDividerLine;
}

class LogTypeSettings {
  LogTypeSettings(this.settings, this.logTypeSettings);

  final LogSettings settings;

  final Map<LogType, LogSettings> logTypeSettings;

  LogSettings operator [](LogType key) {
    return logTypeSettings[key] ?? settings;
  }
}
