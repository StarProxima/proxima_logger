import 'log_level.dart';

import '../ansi_color.dart';

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
    for (var l in Lvl.values) {
      includeBox[l] = !noBoxingByDefault;
    }
    excludeBox.forEach((k, v) => includeBox[k] = !v);
  }

  final int lineLength;
  final bool colors;

  final Map<Lvl, bool> excludeBox;
  final bool noBoxingByDefault;

  late final Map<Lvl, bool> includeBox;

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
    Lvl.verbose: AnsiColor.fg(AnsiColor.grey(0.5)),
    Lvl.debug: AnsiColor.none(),
    Lvl.info: AnsiColor.fg(12),
    Lvl.warning: AnsiColor.fg(208),
    Lvl.error: AnsiColor.fg(196),
    Lvl.wtf: AnsiColor.fg(199),
  };

  static final levelEmojis = {
    Lvl.verbose: '',
    Lvl.debug: '🐛 ',
    Lvl.info: '💡 ',
    Lvl.warning: '⚠️ ',
    Lvl.error: '⛔ ',
    Lvl.wtf: '👾 ',
  };

  AnsiColor _getLevelColor(Lvl level) {
    if (colors) {
      return levelColors[level]!;
    } else {
      return AnsiColor.none();
    }
  }

  AnsiColor _getErrorColor(Lvl level) {
    if (colors) {
      if (level == Lvl.wtf) {
        return levelColors[Lvl.wtf]!.toBg();
      } else {
        return levelColors[Lvl.error]!.toBg();
      }
    } else {
      return AnsiColor.none();
    }
  }

  String _getEmoji(Lvl level) {
    return levelEmojis[level]!;
  }

  List<String> format(
    Lvl level,
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
