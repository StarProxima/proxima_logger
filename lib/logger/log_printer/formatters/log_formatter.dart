// ignore_for_file: prefer_interpolation_to_compose_strings

import '../../proxima_logger.dart';
import '../../support/ansi_pen.dart';

enum LogPart {
  title,
  error,
  stackTrace,
  time,
}

class LogFormatter {
  LogFormatter(
    this.settings,
  ) {
    var doubleDividerLine = StringBuffer();
    var singleDividerLine = StringBuffer();
    for (var i = 0; i < settings.lineLength - 1; i++) {
      doubleDividerLine.write(doubleDivider);
      singleDividerLine.write(singleDivider);
    }

    _topBorder = '$topLeftCorner$doubleDividerLine';
    _middleBorder = '$singleDividerLine';
    _bottomBorder = '$bottomLeftCorner$doubleDividerLine';
  }

  LogSettings settings;

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

  List<String> format(
    String message,
    LogType type,
    String? title,
    String? time,
    String? error,
    String? stacktrace,
  ) {
    List<String> buffer = [];
    var verticalLineAtLevel =
        (settings.includeBox[type]!) ? ('$verticalLine ') : '';

    AnsiPen pen = type.ansiPen;
    AnsiPen penOnBg = type.ansiPenOnBackground;

    String messageWithBg(String msg) {
      return pen.bg(
        pen.isNotNone ? penOnBg.fg(msg) : msg,
      );
    }

    void addMiddleBorder(LogPart part) {
      if (settings.middleBorders[type]![part]!) {
        buffer.add(
          pen.fg(
            '${settings.includeBox[type]! ? middleCorner : ''}$_middleBorder',
          ),
        );
      }
    }

    String emoji = settings.printEmoji ? type.emoji : '';
    String typyLabel = '[${type.label.toUpperCase()}]';
    String topLeftTitleCorner =
        (settings.includeBox[type]!) ? '$topLeftCorner$middleTopCorner ' : '';
    buffer.add(
      pen.fg(
        '$topLeftTitleCorner$emoji$typyLabel $title',
      ),
    );
    addMiddleBorder(LogPart.title);

    if (error != null) {
      for (var line in error.split('\n')) {
        buffer.add(
          pen.fg(verticalLineAtLevel) +
              pen.resetForeground +
              messageWithBg(line) +
              pen.resetBackground,
        );
      }
      addMiddleBorder(LogPart.error);
    }

    if (stacktrace != null) {
      for (var line in stacktrace.split('\n')) {
        buffer.add(pen.fg('$verticalLineAtLevel$line'));
      }
      addMiddleBorder(LogPart.stackTrace);
    }

    if (time != null) {
      buffer.add(pen.fg('$verticalLineAtLevel$time'));
      addMiddleBorder(LogPart.time);
    }

    for (var line in message.split('\n')) {
      buffer.add(pen.fg('$verticalLineAtLevel$line'));
    }
    if (settings.includeBox[type]!) buffer.add(pen.fg(_bottomBorder));

    return buffer;
  }
}
