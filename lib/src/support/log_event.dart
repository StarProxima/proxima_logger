import 'log_type.dart';

class LogEvent {
  final dynamic message;
  final LogType type;
  final String? title;
  final dynamic error;
  final StackTrace? stack;
  final DateTime time;

  LogEvent(
    this.type, {
    this.title,
    this.error,
    this.stack,
    this.message,
    required this.time,
  });
}
