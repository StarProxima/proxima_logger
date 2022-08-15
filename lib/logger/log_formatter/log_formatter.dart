import '../support/log_event.dart';
import '../support/formatted_log_event.dart';
import '../support/log_settings.dart';
import 'formatters/queue_formatter.dart';
import 'formatters/message_formatter.dart';
import 'formatters/stack_trace_formatter.dart';
import 'formatters/time_formatter.dart';

abstract class Formatter {
  void init() {}

  FormattedLogEvent format(LogEvent event);

  void destroy() {}
}

class LogFormatter extends Formatter {
  LogFormatter(
    this.settings,
  );

  LogTypeSettings settings;

  QueueFormatter queueFormatter = QueueFormatter();

  MessageFormatter messageFormatter = MessageFormatter();

  late StackTraceFormatter stackFormatter = StackTraceFormatter(settings);

  late LogTimeFormatter timeFormatter = LogTimeFormatter(
    settings,
    startAppTime: DateTime.now(),
  );

  @override
  FormattedLogEvent format(LogEvent event) {
    List<LogPart> queue =
        queueFormatter.format(event, settings[event.log].logParts);

    String? error;

    if (queue.contains(LogPart.error)) {
      error = event.error?.toString();
    }

    String? stack;

    if (queue.contains(LogPart.stack)) {
      if (event.stack == null) {
        if (settings[event.log].stackTraceMethodCount > 0) {
          stack = stackFormatter.format(
            event.log,
            StackTrace.current,
            isError: false,
          );
        }
      } else if (settings[event.log].errorStackTraceMethodCount > 0) {
        stack = stackFormatter.format(
          event.log,
          event.stack,
          isError: true,
        );
      }
    }

    String? time;

    if (queue.contains(LogPart.time)) {
      time = timeFormatter.getLogTime(event.log);
    }

    String? message;

    if (queue.contains(LogPart.message) && event.message != null) {
      message = messageFormatter.format(event.message);
    }

    FormattedLogEvent formattedLogEvent = FormattedLogEvent(
      log: event.log,
      queue: queue,
      title: event.title,
      error: error,
      stack: stack,
      time: time,
      message: message,
    );

    return formattedLogEvent;
  }
}