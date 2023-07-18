// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'log_settings.dart';
import 'log_type.dart';

class FormattedLogEvent {
  ILogType log;
  List<LogPart> queue;
  String? title;
  String? error;
  String? stack;
  String? time;
  String? message;

  FormattedLogEvent({
    required this.log,
    required this.queue,
    this.title,
    this.error,
    this.stack,
    this.time,
    this.message,
  });
}
