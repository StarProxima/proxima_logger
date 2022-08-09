class LogTimeFormatter {
  final DateTime? startAppTime;

  const LogTimeFormatter([this.startAppTime]);

  String _threeDigits(int n) {
    if (n >= 100) return '$n';
    if (n >= 10) return '0$n';
    return '00$n';
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  String getLogTime() {
    var now = DateTime.now();
    var h = _twoDigits(now.hour);
    var min = _twoDigits(now.minute);
    var sec = _twoDigits(now.second);
    var ms = _threeDigits(now.millisecond);
    if (startAppTime != null) {
      var timeSinceStart = now.difference(startAppTime!).toString();
      return '$h:$min:$sec.$ms (+$timeSinceStart)';
    } else {
      return '$h:$min:$sec.$ms';
    }
  }
}
