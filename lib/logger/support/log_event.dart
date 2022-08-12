import 'log_type.dart';

class LogEvent {
  final dynamic message;
  final LogType type;
  final String? title;
  final dynamic error;
  final StackTrace? stackTrace;

  LogEvent(this.message, this.type, this.title, this.error, this.stackTrace);
}
