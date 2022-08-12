import '../../support/log_type.dart';

class LogTimeFormatter {
  LogTimeFormatter(this.startAppTime);

  final DateTime startAppTime;

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

  String getLogTime(LogType log) {
    DateTime now = DateTime.now();

    String y = _fourDigits(now.year);
    String m = _twoDigits(now.month);
    String d = _twoDigits(now.day);
    String h = _twoDigits(now.hour);
    String min = _twoDigits(now.minute);
    String sec = _twoDigits(now.second);
    String ms = _threeDigits(now.millisecond);

    var timeSinceStart = now.difference(startAppTime).toString();
    return '$h:$min:$sec.$ms (+$timeSinceStart) $d.$m.$y';
  }
}
