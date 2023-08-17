import 'output_event.dart';

abstract class ILogOutput {
  void output(OutputEvent outputEvent);
}

class ConsoleOutput implements ILogOutput {
  @override
  void output(OutputEvent outputEvent) {
    for (final line in outputEvent.lines) {
      // ignore: avoid_print
      print(line);
    }
  }
}
