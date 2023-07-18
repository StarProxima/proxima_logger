import 'output_event.dart';

abstract class LogOutput {
  void output(OutputEvent outputEvent);
}

class ConsoleOutput implements LogOutput {
  @override
  void output(OutputEvent outputEvent) {
    // ignore: avoid_print
    outputEvent.lines.forEach(print);
  }
}
