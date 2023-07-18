import 'log_type.dart';

class LogEvent {
  LogEvent(
    this.type, {
    required this.time,
    this.title,
    this.error,
    this.stack,
    this.message,
  });

  final dynamic message;
  final ILogType type;
  final String? title;
  final dynamic error;
  final StackTrace? stack;
  final DateTime time;
}
