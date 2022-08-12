/// This class handles colorizing of terminal output.
class AnsiPen {
  AnsiPen(this.color);

  AnsiPen.none() : color = null;

  AnsiPen.white() : color = 255;
  AnsiPen.black() : color = 232;
  AnsiPen.red() : color = 196;
  AnsiPen.orange() : color = 208;
  AnsiPen.purple() : color = 199;
  AnsiPen.gold() : color = 220;
  AnsiPen.yelow() : color = 226;
  AnsiPen.blue() : color = 39;
  AnsiPen.navyBlue() : color = 17;
  AnsiPen.green() : color = 40;

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
