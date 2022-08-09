import 'support/log_event.dart';

import 'log_printer/log_printer.dart';
import 'support/log_level.dart';
import 'support/log_output.dart';
export 'support/log_level.dart';

final logger = ProximaLogger();

class ProximaLogger {
  final LogPrinter _printer = PrettyPrinter();
  final LogOutput _output = ConsoleOutput();
  void log(
    Lvl level,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    var logEvent = LogEvent(level, message, error, stackTrace);

    var output = _printer.log(logEvent);

    if (output.isNotEmpty) {
      OutputEvent outputEvent = OutputEvent(level, output);
      try {
        _output.output(outputEvent);
      } catch (e, s) {
        print(e);
        print(s);
      }
    }
  }
}
