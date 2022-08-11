import 'ansi_color.dart';

enum LogType implements LogTypeInterface {
  verbose,
  debug,
  info,
  warning,
  error,
  wtf,
  nothing;

  @override
  String get label => '_label';
  @override
  String? get emoji => '_emoji';
  @override
  AnsiColor get color {
    switch (this) {
      case LogType.verbose:
        return AnsiColor.fg(AnsiColor.grey(0.5));
      case LogType.debug:
        return AnsiColor.none();
      case LogType.info:
        return AnsiColor.fg(12);
      case LogType.warning:
        return AnsiColor.fg(208);
      case LogType.error:
        return AnsiColor.fg(196);
      case LogType.wtf:
        return AnsiColor.fg(199);
      default:
        return AnsiColor.none();
    }
  }
}

abstract class LogTypeInterface {
  String get label;
  String? get emoji;
  AnsiColor get color;
}
