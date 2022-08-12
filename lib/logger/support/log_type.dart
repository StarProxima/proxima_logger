import 'ansi_pen.dart';

enum Log implements LogType {
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
      case Log.verbose:
        return 'verbose';
      case Log.debug:
        return 'debug';
      case Log.info:
        return 'info';
      case Log.warning:
        return 'warning';
      case Log.error:
        return 'error';
      case Log.wtf:
        return 'wtf';
      default:
        return '';
    }
  }

  @override
  String get emoji {
    switch (this) {
      case Log.verbose:
        return '';
      case Log.debug:
        return '🐛';
      case Log.info:
        return '💡';
      case Log.warning:
        return '⚠️';
      case Log.error:
        return '⛔';
      case Log.wtf:
        return '👾';
      default:
        return '';
    }
  }

  @override
  AnsiPen get ansiPen {
    switch (this) {
      case Log.verbose:
        return AnsiPen(AnsiPen.grey(0.5));
      case Log.debug:
        return AnsiPen.none();
      case Log.info:
        return AnsiPen.white();
      case Log.warning:
        return AnsiPen.orange();
      case Log.error:
        return AnsiPen.red();
      case Log.wtf:
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

abstract class LogType {
  String get label;
  String get emoji;
  AnsiPen get ansiPen;
  AnsiPen get ansiPenOnBackground;
}
