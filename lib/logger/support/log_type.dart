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
  String? get emoji {
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
        return null;
    }
  }

  @override
  AnsiPen? get color {
    switch (this) {
      case LogType.verbose:
        return AnsiPen(AnsiPen.grey(0.5));
      case LogType.debug:
        return AnsiPen.none();
      case LogType.info:
        return AnsiPen(12);
      case LogType.warning:
        return AnsiPen(208);
      case LogType.error:
        return AnsiPen(196);
      case LogType.wtf:
        return AnsiPen(199);
      default:
        return AnsiPen.none();
    }
  }

  @override
  AnsiPen? get colorOnBackground {
    return AnsiPen.white();
  }
}

abstract class LogTypeInterface {
  String get label;
  String? get emoji;
  AnsiPen? get color;
  AnsiPen? get colorOnBackground;
}
