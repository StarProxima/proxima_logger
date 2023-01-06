import 'output_event.dart';

abstract class LogOutput {
  void output(OutputEvent outputEvent);
}

class ConsoleOutput implements LogOutput {
  @override
  void output(OutputEvent outputEvent) {
    outputEvent.lines.forEach(print);
  }
}
