// ignore_for_file: prefer_interpolation_to_compose_strings

import '../support/ansi_pen.dart';
import '../support/log_decorations.dart';
import '../support/formatted_log_event.dart';
import '../support/log_settings.dart';

class LogDecorator {
  LogDecorator(
    this.settings,
  );

  LogTypeSettings settings;

  List<LogPart> _formatQueue(FormattedLogEvent event, List<LogPart> list) {
    List<LogPart> queue = [];

    for (LogPart part in list) {
      switch (part) {
        case LogPart.error:
          if (event.error == null) continue;
          break;
        case LogPart.stack:
          if (event.stack == null) continue;
          break;
        case LogPart.time:
          if (event.time == null) continue;
          break;
        case LogPart.message:
          if (event.message == null) continue;
          break;
        default:
      }

      if (queue.isNotEmpty) {
        if (queue.last != part) {
          queue.add(part);
        }
      } else {
        queue.add(part);
      }
    }

    while (queue.isNotEmpty && queue.last == LogPart.divider) {
      queue.removeLast();
    }

    return queue;
  }

  String _getTitle(FormattedLogEvent event) {
    LogSettings st = settings[event.log];
    LogDecorations ld = settings[event.log].logDecorations;

    String topLeftTitleCorner =
        st.leftBorder ? '${ld.topLeftCorner}${ld.middleTopCorner} ' : '';

    String emoji = st.printEmoji ? event.log.emoji : '';

    String logTypeLabel = st.printLogTypeLabel
        ? st.decorateLogTypeLabel
            ? '[${event.log.label.toUpperCase()}]'
            : event.log.label
        : '';

    String titleStr = st.printTitle
        ? event.title != null
            ? ' ${event.title}'
            : ''
        : '';

    return '$topLeftTitleCorner$emoji$logTypeLabel$titleStr';
  }

  List<String> format(FormattedLogEvent event) {
    LogSettings st = settings[event.log];
    LogDecorations ld = settings[event.log].logDecorations;
    AnsiPen pen = event.log.ansiPen;

    List<LogPart> queue = _formatQueue(event, st.logParts);

    String? error = event.error;
    String? stack = event.stack;
    String? time = event.time;
    String? message = event.message;

    List<String> buffer = [];

    buffer.add(pen.fg(_getTitle(event)));

    String verticalLineAtLevel = st.leftBorder ? '${ld.verticalLine} ' : '';

    String middleDivider =
        '${st.leftBorder ? ld.middleCorner : ''}${ld.middleDividerLine}';

    for (LogPart part in queue) {
      switch (part) {
        case LogPart.error:
          if (error != null) {
            for (var line in error.split('\n')) {
              buffer.add(
                pen.fg(verticalLineAtLevel) +
                    pen.resetForeground +
                    (st.selectError
                        ? pen.bg(
                            pen.isNotNone
                                ? event.log.ansiPenOnBackground.fg(line)
                                : line,
                          )
                        : pen.fg(line)) +
                    pen.resetBackground,
              );
            }
          }
          break;
        case LogPart.stack:
          if (stack != null) {
            for (var line in stack.split('\n')) {
              buffer.add(pen.fg('$verticalLineAtLevel$line'));
            }
          }
          break;
        case LogPart.time:
          if (time != null) {
            buffer.add(pen.fg('$verticalLineAtLevel$time'));
          }
          break;
        case LogPart.message:
          if (message != null) {
            for (var line in message.split('\n')) {
              buffer.add(pen.fg('$verticalLineAtLevel$line'));
            }
          }
          break;
        case LogPart.divider:
          buffer.add(pen.fg(middleDivider));
          break;
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
