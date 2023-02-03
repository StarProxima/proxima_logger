import '../support/log_event.dart';
import '../support/formatted_log_event.dart';
import '../support/log_settings.dart';
import 'formatters/queue_formatter.dart';
import 'formatters/message_formatter.dart';
import 'formatters/stack_trace_formatter.dart';
import 'formatters/time_formatter.dart';

/// Formats a [LogEvent] into a [FormattedLogEvent]. Formats a message, stacktrace, time, and queue [LogPart].
abstract class LogFormatter {
  FormattedLogEvent format(LogEvent event);

  /// Default implementation of [LogFormatter].
  factory LogFormatter(LogTypeSettings settings) =>
      DefaultLogFormatter(settings);
}

class DefaultLogFormatter implements LogFormatter {
  final LogTypeSettings settings;

  late final QueueFormatter queueFormatter;
  late final MessageFormatter messageFormatter;
  late final StackTraceFormatter stackFormatter;
  late final LogTimeFormatter timeFormatter;

  DefaultLogFormatter(
    this.settings, {
    QueueFormatter? queueFormatter,
    MessageFormatter? messageFormatter,
    StackTraceFormatter? stackFormatter,
    LogTimeFormatter? logTimeFormatter,
  }) {
    this.queueFormatter = queueFormatter ?? QueueFormatter();
    this.messageFormatter = messageFormatter ?? MessageFormatter();
    this.stackFormatter = stackFormatter ??
        StackTraceFormatter(
          settings,
        );
    this.timeFormatter = logTimeFormatter ??
        LogTimeFormatter(
          settings,
          startAppTime: DateTime.now(),
        );
  }

  @override
  FormattedLogEvent format(LogEvent event) {
    List<LogPart> queue =
        queueFormatter.format(event, settings[event.type].logParts);

    String? error;

    if (queue.contains(LogPart.error)) {
      error = event.error?.toString();
    }

    String? stack;

    if (queue.contains(LogPart.stack)) {
      if (event.stack == null) {
        if (settings[event.type].stackTraceMethodCount > 0) {
          stack = stackFormatter.format(
            event.type,
            StackTrace.current,
            isError: false,
          );
        }
      } else if (settings[event.type].errorStackTraceMethodCount > 0) {
        stack = stackFormatter.format(
          event.type,
          event.stack,
          isError: true,
        );
      }
    }

    String? time;

    if (queue.contains(LogPart.time)) {
      time = timeFormatter.getLogTime(event.time, event.type);
    }

    String? message;

    if (queue.contains(LogPart.message) && event.message != null) {
      message = messageFormatter.format(event.message);
    }

    FormattedLogEvent formattedLogEvent = FormattedLogEvent(
      log: event.type,
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
