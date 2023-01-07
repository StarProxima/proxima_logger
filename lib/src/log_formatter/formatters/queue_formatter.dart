import '../../support/log_event.dart';
import '../../support/log_settings.dart';

/// A [QueueFormatter] formats a list of [LogPart]s.
abstract class QueueFormatter {
  List<LogPart> format(LogEvent event, List<LogPart> list);

  /// Default implementation of [QueueFormatter]. Removes unnecessary [LogPart] if there is no data for them.
  factory QueueFormatter() => _DefaultQueueFormatter();
}

class _DefaultQueueFormatter implements QueueFormatter {
  List<LogPart> format(LogEvent event, List<LogPart> list) {
    List<LogPart> queue = [];

    for (LogPart part in list) {
      switch (part) {
        case LogPart.error:
          if (event.error == null) continue;
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
}
