import 'log_level.dart';

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
