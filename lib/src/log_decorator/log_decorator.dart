// ignore_for_file: prefer_interpolation_to_compose_strings

import '../support/formatted_log_event.dart';
import '../support/log_settings.dart';

/// Interface for [ILogDecorator].
abstract class ILogDecorator {
  List<String> decorate(FormattedLogEvent event);
}

/// Default implementation of [ILogDecorator]. Decorates logs with borders, emojis and colors.
class LogDecorator implements ILogDecorator {
  LogDecorator(this.settings);

  SettingsBuilder settings;

  String _getTitle(FormattedLogEvent event) {
    final st = settings(event.log);
    final ld = settings(event.log).logDecorations;

    final topLeftTitleCorner =
        st.leftBorder ? '${ld.topLeftCorner}${ld.middleTopCorner} ' : '';

    final emoji = st.printEmoji ? event.log.emoji : '';

    final logTypeLabel = st.printLogTypeLabel
        ? st.decorateLogTypeLabel
            ? '[${event.log.label.toUpperCase()}]'
            : event.log.label
        : '';

    final titleStr = st.printTitle
        ? event.title != null
            ? ' ${event.title}'
            : ''
        : '';

    return '$topLeftTitleCorner$emoji$logTypeLabel$titleStr';
  }

  @override
  List<String> decorate(FormattedLogEvent event) {
    final set = settings(event.log);
    final dec = settings(event.log).logDecorations;
    final pen = event.log.ansiPen;

    final error = event.error;
    final stack = event.stack;
    final time = event.time;
    final message = event.message;

    final buffer = <String>[pen.fg(_getTitle(event))];

    final verticalLineAtLevel = set.leftBorder ? '${dec.verticalLine} ' : '';

    final middleDivider =
        '${set.leftBorder ? dec.middleCorner : ''}${dec.middleDivider * set.lineLength}';

    for (final part in event.queue) {
      switch (part) {
        case LogPart.error:
          if (error != null) {
            for (final line in error.split('\n')) {
              buffer.add(
                pen.fg(verticalLineAtLevel) +
                    pen.resetForeground +
                    (set.selectError
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
            for (final line in stack.split('\n')) {
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
            for (final line in message.split('\n')) {
              buffer.add(pen.fg('$verticalLineAtLevel$line'));
            }
          }
          break;
        case LogPart.divider:
          buffer.add(pen.fg(middleDivider));
          break;
      }
    }

    if (set.bottomBorder) {
      buffer.add(
        pen.fg(
          '${set.leftBorder ? dec.bottomLeftCorner : dec.divider}${dec.divider * set.lineLength}',
        ),
      );
    }

    return buffer;
  }
}
