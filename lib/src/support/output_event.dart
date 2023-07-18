import '../../proxima_logger.dart';

class OutputEvent {
  final ILogType type;
  final LogEvent logEvent;
  final FormattedLogEvent formattedLogEvent;
  final List<String> lines;

  OutputEvent({
    required this.type,
    required this.logEvent,
    required this.formattedLogEvent,
    required this.lines,
  });
}
