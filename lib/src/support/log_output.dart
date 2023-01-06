import 'log_type.dart';

class OutputEvent {
  final LogType level;
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
    event.lines.forEach(print);
  }
}
