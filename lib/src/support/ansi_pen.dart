/// This class handles colorizing of terminal output.
class AnsiPen {
  const AnsiPen(this.color);

  const AnsiPen.none() : color = null;

  const AnsiPen.white() : color = 255;
  const AnsiPen.black() : color = 232;
  const AnsiPen.red() : color = 196;
  const AnsiPen.orange() : color = 208;
  const AnsiPen.purple() : color = 199;
  const AnsiPen.gold() : color = 220;
  const AnsiPen.yelow() : color = 226;
  const AnsiPen.blue() : color = 39;
  const AnsiPen.navyBlue() : color = 17;
  const AnsiPen.green() : color = 40;

  final int? color;

  bool get isNotNone => color != null;

  /// ANSI Control Sequence Introducer, signals the terminal for new settings.
  static const ansiEsc = '\x1B[';

  /// Reset all colors and options for current SGRs to terminal defaults.
  static const ansiDefault = '${ansiEsc}0m';

  String fg(String msg) {
    if (color != null) {
      return '${ansiEsc}38;5;${color}m$msg$ansiDefault';
    } else {
      return msg;
    }
  }

  String bg(String msg) {
    if (color != null) {
      return '${ansiEsc}48;5;${color}m$msg$ansiDefault';
    } else {
      return msg;
    }
  }

  /// Defaults the terminal's foreground color without altering the background.
  String get resetForeground => color != null ? '${ansiEsc}39m' : '';

  /// Defaults the terminal's background color without altering the foreground.
  String get resetBackground => color != null ? '${ansiEsc}49m' : '';

  static int grey(double level) => 232 + (level.clamp(0.0, 1.0) * 23).round();
}
