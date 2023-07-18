import '../../support/log_settings.dart';
import '../../support/log_type.dart';

/// A [ILogTimeFormatter] formats a [DateTime] to a [String].
abstract class ILogTimeFormatter {
  String getLogTime(DateTime time, ILogType log);
}

/// Default implementation of [LogTimeFormatter].
class LogTimeFormatter implements ILogTimeFormatter {
  final LogTypeSettings settings;
  final DateTime startAppTime;

  LogTimeFormatter(this.settings, {required this.startAppTime});

  static String _fourDigits(int n) {
    if (n >= 1000) return "$n";
    if (n >= 100) return "0$n";
    if (n >= 10) return "00$n";
    return "000$n";
  }

  static String _threeDigits(int n) {
    if (n >= 100) return '$n';
    if (n >= 10) return '0$n';
    return '00$n';
  }

  static String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  String getLogTime(DateTime time, ILogType log) {
    DateTime now = DateTime.now();

    String date = '';
    if (settings[log].printDateInTime) {
      String y = _fourDigits(now.year);
      String m = _twoDigits(now.month);
      String d = _twoDigits(now.day);
      date = '$d.$m.$y';
    }

    String h = _twoDigits(now.hour);
    String min = _twoDigits(now.minute);
    String sec = _twoDigits(now.second);
    String ms = _threeDigits(now.millisecond);

    String timeSinceStart = '';
    if (settings[log].printTimeSinceStartInTime) {
      timeSinceStart = '(+${now.difference(startAppTime).toString()})';
    }

    return '$h:$min:$sec.$ms $timeSinceStart $date';
  }
}
