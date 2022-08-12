// ignore_for_file: prefer_interpolation_to_compose_strings

import '../../support/ansi_pen.dart';
import '../../support/log_type.dart';

class LogFormatter {
  LogFormatter({
    this.lineLength = 120,
    this.colors = true,
    this.excludeBox = const {},
    this.printEmoji = true,
    required this.includeBox,
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
  }

  final int lineLength;
  final bool colors;

  final bool printEmoji;

  final Map<LogTypeInterface, bool> excludeBox;

  final Map<LogTypeInterface, bool> includeBox;

  String _topBorder = '';
  String _middleBorder = '';
  String _bottomBorder = '';

  static const topLeftCorner = '┌';
  static const bottomLeftCorner = '└';
  static const middleCorner = '├';
  static const middleTopCorner = '┤';
  static const verticalLine = '│';
  static const doubleDivider = '─';
  static const singleDivider = '┄';

  // static final levelColors = {
  //   LogType.verbose: AnsiColor.fg(AnsiColor.grey(0.5)),
  //   LogType.debug: AnsiColor.none(),
  //   LogType.info: AnsiColor.fg(12),
  //   LogType.warning: AnsiColor.fg(208),
  //   LogType.error: AnsiColor.fg(196),
  //   LogType.wtf: AnsiColor.fg(199),
  // };

  // static final levelEmojis = {
  //   LogType.verbose: '',
  //   LogType.debug: '🐛',
  //   LogType.info: '💡',
  //   LogType.warning: '⚠️',
  //   LogType.error: '⛔',
  //   LogType.wtf: '👾',
  // };

  // AnsiColor _getLevelColor(LogType level) {
  //   if (colors) {
  //     return levelColors[level]!;
  //   } else {
  //     return AnsiColor.none();
  //   }
  // }

  // String _getEmoji(LogType level) {
  //   return levelEmojis[level]!;
  // }

  List<String> format(
    String message,
    LogTypeInterface type,
    String? title,
    String? time,
    String? error,
    String? stacktrace,
  ) {
    List<String> buffer = [];
    var verticalLineAtLevel = (includeBox[type]!) ? ('$verticalLine ') : '';
    AnsiPen pen = type.ansiPen;
    AnsiPen penOnBg = type.ansiPenOnBackground;
    // if (includeBox[level]!) buffer.add(color(_topBorder));

    String messageWithBg(String msg) {
      return pen.bg(
        pen.isNotNone ? penOnBg.fg(msg) : msg,
      );
    }

    buffer.add(
      pen.fg(
        '$topLeftCorner$middleTopCorner ${printEmoji ? type.emoji : ''}[${type.label.toUpperCase()}] ${title ?? ''}',
      ),
    );
    //if (includeBox[level]!) buffer.add(color(_middleBorder));

    if (error != null) {
      for (var line in error.split('\n')) {
        buffer.add(
          pen.fg(verticalLineAtLevel) +
              pen.resetForeground +
              messageWithBg(line) +
              pen.resetBackground,
        );
      }
      // if (includeBox[level]!) buffer.add(color(_middleBorder));
    }

    if (stacktrace != null) {
      for (var line in stacktrace.split('\n')) {
        buffer.add(pen.fg('$verticalLineAtLevel$line'));
      }
      //if (includeBox[level]!) buffer.add(color(_middleBorder));
    }

    if (time != null) {
      buffer.add(pen.fg('$verticalLineAtLevel$time'));
      //if (includeBox[level]!) buffer.add(color(_middleBorder));
    }

    for (var line in message.split('\n')) {
      buffer.add(pen.fg('$verticalLineAtLevel$line'));
    }
    if (includeBox[type]!) buffer.add(pen.fg(_bottomBorder));

    return buffer;
  }
}
