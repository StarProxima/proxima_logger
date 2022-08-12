import 'log_type.dart';

class LogEvent {
  final dynamic message;
  final LogType log;
  final String? title;
  final dynamic error;
  final StackTrace? stack;

  LogEvent(
    this.log, {
    this.title,
    this.error,
    this.stack,
    this.message,
  });
}
