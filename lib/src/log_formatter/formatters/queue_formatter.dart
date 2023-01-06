import '../../support/log_event.dart';
import '../../support/log_settings.dart';

class QueueFormatter {
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