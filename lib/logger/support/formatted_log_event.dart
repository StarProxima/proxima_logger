import 'log_type.dart';

class FormattedLogEvent {
  LogType log;
  String? title;
  String? error;
  String? stack;
  String? time;
  String? message;

  FormattedLogEvent(
    this.log, {
    this.title,
    this.error,
    this.stack,
    this.time,
    this.message,
  });
}
