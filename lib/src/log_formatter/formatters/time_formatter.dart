import '../../support/log_settings.dart';
import '../../support/log_type.dart';

/// A [ILogTimeFormatter] formats a [DateTime] to a [String].
abstract class ILogTimeFormatter {
  String getLogTime(DateTime time, ILogType log);
}

/// Default implementation of [LogTimeFormatter].
class LogTimeFormatter implements ILogTimeFormatter {
  LogTimeFormatter(
    this.settings, {
    required this.startAppTime,
  });

  final SettingsBuilder settings;
  final DateTime startAppTime;

  static String _fourDigits(int n) {
    if (n >= 1000) return '$n';
    if (n >= 100) return '0$n';
    if (n >= 10) return '00$n';
    return '000$n';
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

  @override
  String getLogTime(DateTime time, ILogType log) {
    final now = DateTime.now();

    var date = '';
    if (settings(log).printDateInTime) {
      final y = _fourDigits(now.year);
      final m = _twoDigits(now.month);
      final d = _twoDigits(now.day);
      date = '$d.$m.$y';
    }

    final h = _twoDigits(now.hour);
    final min = _twoDigits(now.minute);
    final sec = _twoDigits(now.second);
    final ms = _threeDigits(now.millisecond);

    var timeSinceStart = '';
    if (settings(log).printTimeSinceStartInTime) {
      timeSinceStart = '(+${now.difference(startAppTime).toString()})';
    }

    return '$h:$min:$sec.$ms $timeSinceStart $date';
  }
}
