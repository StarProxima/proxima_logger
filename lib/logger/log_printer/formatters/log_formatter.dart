// ignore_for_file: prefer_interpolation_to_compose_strings

import '../../proxima_logger.dart';
import '../../support/ansi_pen.dart';
import '../../support/log_decorations.dart';
import '../../support/log_settings.dart';

class LogFormatter {
  LogFormatter(
    this.settings,
  );

  LogTypeSettings settings;

  List<String> format(
    LogType log, {
    String? title,
    String? error,
    String? stacktrace,
    String? time,
    String? message,
  }) {
    List<String> buffer = [];

    LogSettings st = settings[log];
    LogDecorations ld = settings[log].logDecorations;

    AnsiPen pen = log.ansiPen;
    AnsiPen penOnBg = log.ansiPenOnBackground;

    String messageWithBg(String msg) {
      if (st.selectError) {
        return pen.bg(
          pen.isNotNone ? penOnBg.fg(msg) : msg,
        );
      }
      return pen.fg(msg);
    }

    String verticalLineAtLevel = st.leftBorder ? '${ld.verticalLine} ' : '';

    String middleDivider =
        '${st.leftBorder ? ld.middleCorner : ''}${ld.middleDividerLine}';

    String topLeftTitleCorner =
        st.leftBorder ? '${ld.topLeftCorner}${ld.middleTopCorner} ' : '';

    String emoji = st.printEmoji ? log.emoji : '';

    String logTypeLabel = st.printLogTypeLabel
        ? st.decorateLogTypeLabel
            ? '[${log.label.toUpperCase()}]'
            : log.label
        : '';

    String titleStr = st.printTitle
        ? title != null
            ? ' $title'
            : ''
        : '';

    buffer.add(
      pen.fg(
        '$topLeftTitleCorner$emoji$logTypeLabel$titleStr',
      ),
    );

    if (error != null) {
      if (st.dividerOverError) buffer.add(pen.fg(middleDivider));
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
      if (st.dividerOverStack) buffer.add(pen.fg(middleDivider));
      for (var line in stacktrace.split('\n')) {
        buffer.add(pen.fg('$verticalLineAtLevel$line'));
      }
    }

    if (time != null) {
      if (st.dividerOverTime) buffer.add(pen.fg(middleDivider));
      buffer.add(pen.fg('$verticalLineAtLevel$time'));
    }

    if (message != null) {
      if (settings[log].dividerOverMessage) buffer.add(pen.fg(middleDivider));
      for (var line in message.split('\n')) {
        buffer.add(pen.fg('$verticalLineAtLevel$line'));
      }
    }

    if (st.bottomBorder) {
      buffer.add(
        pen.fg(
          '${st.leftBorder ? ld.bottomLeftCorner : ld.divider}${ld.dividerLine}',
        ),
      );
    }

    return buffer;
  }
}
