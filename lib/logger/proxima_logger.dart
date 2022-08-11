// ignore_for_file: avoid_print

import 'support/log_event.dart';

import 'log_printer/log_printer.dart';
import 'support/log_type.dart';
import 'support/log_output.dart';
export 'support/log_type.dart';

final logger = ProximaLogger();

class ProximaLogger {
  final LogPrinter _printer = PrettyPrinter();
  final LogOutput _output = ConsoleOutput();
  void log(
    dynamic message, [
    LogTypeInterface type = LogType.info,
    String? title,
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    var logEvent = LogEvent(message, type, title, error, stackTrace);

    var output = _printer.log(logEvent);

    if (output.isNotEmpty) {
      OutputEvent outputEvent = OutputEvent(type, output);
      try {
        _output.output(outputEvent);
      } catch (e, s) {
        print(e);
        print(s);
      }
    }
  }
}
