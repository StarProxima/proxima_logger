import 'package:proxima_logger/proxima_logger.dart';

final logger = ProximaLogger();

enum Log implements LogType {
  info,
  debug,
  warning,
  error,
  wtf,
  request,
  response,
  nothing;

  @override
  String get label {
    switch (this) {
      case Log.info:
        return 'info';
      case Log.debug:
        return 'debug';
      case Log.warning:
        return 'warning';
      case Log.error:
        return 'error';
      case Log.wtf:
        return 'wtf';
      case Log.request:
        return 'request';
      case Log.response:
        return 'response';
      default:
        return '';
    }
  }

  @override
  String get emoji {
    switch (this) {
      case Log.info:
        return '💡';
      case Log.debug:
        return '🐛';
      case Log.warning:
        return '⚠️';
      case Log.error:
        return '⛔';
      case Log.wtf:
        return '👾';
      case Log.request:
        return '📡';
      case Log.response:
        return '📡';
      default:
        return '';
    }
  }

  @override
  AnsiPen get ansiPen {
    switch (this) {
      case Log.info:
        return AnsiPen.none();
      case Log.debug:
        return AnsiPen.green();
      case Log.warning:
        return AnsiPen.orange();
      case Log.error:
        return AnsiPen.red();
      case Log.wtf:
        return AnsiPen.purple();
      case Log.request:
        return AnsiPen.blue();
      case Log.response:
        return AnsiPen.blue();
      default:
        return AnsiPen.none();
    }
  }

  @override
  AnsiPen get ansiPenOnBackground {
    return AnsiPen.black();
  }
}
