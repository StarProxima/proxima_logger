import 'log_level.dart';

class LogEvent {
  final Lvl level;
  final dynamic message;
  final dynamic error;
  final StackTrace? stackTrace;

  LogEvent(this.level, this.message, this.error, this.stackTrace);
}
