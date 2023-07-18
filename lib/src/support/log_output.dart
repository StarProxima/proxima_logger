import 'output_event.dart';

abstract class LogOutput {
  void output(OutputEvent outputEvent);
}

class ConsoleOutput implements LogOutput {
  @override
  void output(OutputEvent outputEvent) {
    for (final line in outputEvent.lines) {
      // ignore: avoid_print
      print(line);
    }
  }
}
