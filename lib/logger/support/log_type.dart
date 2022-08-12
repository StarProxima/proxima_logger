import 'ansi_pen.dart';

enum LogType implements LogTypeInterface {
  verbose,
  debug,
  info,
  warning,
  error,
  wtf,
  nothing;

  @override
  String get label {
    switch (this) {
      case LogType.verbose:
        return 'verbose';
      case LogType.debug:
        return 'debug';
      case LogType.info:
        return 'info';
      case LogType.warning:
        return 'warning';
      case LogType.error:
        return 'error';
      case LogType.wtf:
        return 'wtf';
      default:
        return '';
    }
  }

  @override
  String get emoji {
    switch (this) {
      case LogType.verbose:
        return '';
      case LogType.debug:
        return '🐛';
      case LogType.info:
        return '💡';
      case LogType.warning:
        return '⚠️';
      case LogType.error:
        return '⛔';
      case LogType.wtf:
        return '👾';
      default:
        return '';
    }
  }

  @override
  AnsiPen get ansiPen {
    switch (this) {
      case LogType.verbose:
        return AnsiPen(AnsiPen.grey(0.5));
      case LogType.debug:
        return AnsiPen.none();
      case LogType.info:
        return AnsiPen.white();
      case LogType.warning:
        return AnsiPen.orange();
      case LogType.error:
        return AnsiPen.red();
      case LogType.wtf:
        return AnsiPen.purple();
      default:
        return AnsiPen.none();
    }
  }

  @override
  AnsiPen get ansiPenOnBackground {
    return AnsiPen.black();
  }
}

abstract class LogTypeInterface {
  String get label;
  String get emoji;
  AnsiPen get ansiPen;
  AnsiPen get ansiPenOnBackground;
}
