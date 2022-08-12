// ignore_for_file: prefer_interpolation_to_compose_strings

import '../../proxima_logger.dart';
import '../../support/ansi_pen.dart';
import '../../support/log_settings.dart';

class LogFormatter {
  LogFormatter(
    this.settings,
  );

  LogTypeSettings settings;

  static const topLeftCorner = '┌';
  static const bottomLeftCorner = '└';
  static const middleCorner = '├';
  static const middleTopCorner = '┤';
  static const verticalLine = '│';
  static const doubleDivider = '─';
  static const singleDivider = '┄';

  List<String> format(
    LogType log, {
    String? title,
    String? error,
    String? stacktrace,
    String? time,
    String? message,
  }) {
    List<String> buffer = [];
    String verticalLineAtLevel =
        settings[log].leftBorder ? '$verticalLine ' : '';

    String middleDivider =
        '${settings[log].leftBorder ? middleCorner : ''}${settings[log].singleDividerLine}';

    AnsiPen pen = log.ansiPen;
    AnsiPen penOnBg = log.ansiPenOnBackground;

    String messageWithBg(String msg) {
      if (settings[log].selectError) {
        return pen.bg(
          pen.isNotNone ? penOnBg.fg(msg) : msg,
        );
      }
      return pen.fg(msg);
    }

    String emoji = settings[log].printEmoji ? log.emoji : '';
    String logTypeLabel = settings[log].decorateLogTypeLabel
        ? '[${log.label.toUpperCase()}]'
        : log.label;
    String topLeftTitleCorner =
        settings[log].leftBorder ? '$topLeftCorner$middleTopCorner ' : '';

    String titleStr = title != null ? ' $title' : '';
    buffer.add(
      pen.fg(
        '$topLeftTitleCorner$emoji$logTypeLabel$titleStr',
      ),
    );

    if (error != null) {
      if (settings[log].dividerOverError) buffer.add(pen.fg(middleDivider));
      for (var line in error.split('\n')) {
        buffer.add(
          pen.fg(verticalLineAtLevel) +
              pen.resetForeground +
              messageWithBg(line) +
              pen.resetBackground,
        );
      }
    }

    if (stacktrace != null) {
      if (settings[log].dividerOverStack) buffer.add(pen.fg(middleDivider));
      for (var line in stacktrace.split('\n')) {
        buffer.add(pen.fg('$verticalLineAtLevel$line'));
      }
    }

    if (time != null) {
      if (settings[log].dividerOverTime) buffer.add(pen.fg(middleDivider));
      buffer.add(pen.fg('$verticalLineAtLevel$time'));
    }

    if (message != null) {
      if (settings[log].dividerOverMessage) buffer.add(pen.fg(middleDivider));
      for (var line in message.split('\n')) {
        buffer.add(pen.fg('$verticalLineAtLevel$line'));
      }
    }

    if (settings[log].bottomBorder) {
      buffer.add(
        pen.fg(
          '${settings[log].leftBorder ? bottomLeftCorner : doubleDivider}${settings[log].doubleDividerLine}',
        ),
      );
    }

    return buffer;
  }
}
