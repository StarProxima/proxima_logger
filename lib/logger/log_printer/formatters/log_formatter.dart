import '../../support/log_type.dart';

import '../../support/ansi_color.dart';

class LogFormatter {
  LogFormatter({
    this.lineLength = 120,
    this.colors = true,
    this.excludeBox = const {},
    this.noBoxingByDefault = false,
  }) {
    var doubleDividerLine = StringBuffer();
    var singleDividerLine = StringBuffer();
    for (var i = 0; i < lineLength - 1; i++) {
      doubleDividerLine.write(doubleDivider);
      singleDividerLine.write(singleDivider);
    }

    _topBorder = '$topLeftCorner$doubleDividerLine';
    _middleBorder = '$middleCorner$singleDividerLine';
    _bottomBorder = '$bottomLeftCorner$doubleDividerLine';

    includeBox = {};
    for (var l in LogType.values) {
      includeBox[l] = !noBoxingByDefault;
    }
    excludeBox.forEach((k, v) => includeBox[k] = !v);
  }

  final int lineLength;
  final bool colors;

  final Map<LogType, bool> excludeBox;
  final bool noBoxingByDefault;

  late final Map<LogType, bool> includeBox;

  String _topBorder = '';
  String _middleBorder = '';
  String _bottomBorder = '';

  static const topLeftCorner = '┌';
  static const bottomLeftCorner = '└';
  static const middleCorner = '├';
  static const verticalLine = '│';
  static const doubleDivider = '─';
  static const singleDivider = '┄';

  static final levelColors = {
    LogType.verbose: AnsiColor.fg(AnsiColor.grey(0.5)),
    LogType.debug: AnsiColor.none(),
    LogType.info: AnsiColor.fg(12),
    LogType.warning: AnsiColor.fg(208),
    LogType.error: AnsiColor.fg(196),
    LogType.wtf: AnsiColor.fg(199),
  };

  static final levelEmojis = {
    LogType.verbose: '',
    LogType.debug: '🐛 ',
    LogType.info: '💡 ',
    LogType.warning: '⚠️ ',
    LogType.error: '⛔ ',
    LogType.wtf: '👾 ',
  };

  AnsiColor _getLevelColor(LogType level) {
    if (colors) {
      return levelColors[level]!;
    } else {
      return AnsiColor.none();
    }
  }

  AnsiColor _getErrorColor(LogType level) {
    if (colors) {
      if (level == LogType.wtf) {
        return levelColors[LogType.wtf]!.toBg();
      } else {
        return levelColors[LogType.error]!.toBg();
      }
    } else {
      return AnsiColor.none();
    }
  }

  String _getEmoji(LogType level) {
    return levelEmojis[level]!;
  }

  List<String> format(
    LogType level,
    String message,
    String? time,
    String? error,
    String? stacktrace,
  ) {
    List<String> buffer = [];
    var verticalLineAtLevel = (includeBox[level]!) ? ('$verticalLine ') : '';
    var color = _getLevelColor(level);
    if (includeBox[level]!) buffer.add(color(_topBorder));

    if (error != null) {
      var errorColor = _getErrorColor(level);
      for (var line in error.split('\n')) {
        buffer.add(
          color(verticalLineAtLevel) +
              errorColor.resetForeground +
              errorColor(line) +
              errorColor.resetBackground,
        );
      }
      if (includeBox[level]!) buffer.add(color(_middleBorder));
    }

    if (stacktrace != null) {
      for (var line in stacktrace.split('\n')) {
        buffer.add(color('$verticalLineAtLevel$line'));
      }
      if (includeBox[level]!) buffer.add(color(_middleBorder));
    }

    if (time != null) {
      buffer.add(color('$verticalLineAtLevel$time'));
      if (includeBox[level]!) buffer.add(color(_middleBorder));
    }

    var emoji = _getEmoji(level);
    for (var line in message.split('\n')) {
      buffer.add(color('$verticalLineAtLevel$emoji$line'));
    }
    if (includeBox[level]!) buffer.add(color(_bottomBorder));

    return buffer;
  }
}
