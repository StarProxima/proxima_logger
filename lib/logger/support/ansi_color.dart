/// This class handles colorizing of terminal output.
class AnsiPen {
  AnsiPen(this.color);

  AnsiPen.none() : color = null;

  AnsiPen.white() : color = 255;

  final int? color;

  /// ANSI Control Sequence Introducer, signals the terminal for new settings.
  static const ansiEsc = '\x1B[';

  /// Reset all colors and options for current SGRs to terminal defaults.
  static const ansiDefault = '${ansiEsc}0m';
  static const ansiInverse = '${ansiEsc}27m';

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
