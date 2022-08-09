import 'log_printer/log_level.dart';
import 'log_printer/log_printer.dart';
export 'log_printer/log_level.dart';

final logger = ProximaLogger();

class LogEvent {
  final Lvl level;
  final dynamic message;
  final dynamic error;
  final StackTrace? stackTrace;

  LogEvent(this.level, this.message, this.error, this.stackTrace);
}

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
      var outputEvent = OutputEvent(level, output);
      // Issues with log output should NOT influence
      // the main software behavior.
      try {
        _output.output(outputEvent);
      } catch (e, s) {
        print(e);
        print(s);
      }
    }
  }
}

class OutputEvent {
  final Lvl level;
  final List<String> lines;

  OutputEvent(this.level, this.lines);
}

abstract class LogOutput {
  void init() {}

  void output(OutputEvent event);

  void destroy() {}
}

class ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    // ignore: avoid_print
    event.lines.forEach(print);
  }
}
