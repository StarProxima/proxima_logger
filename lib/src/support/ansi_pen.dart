/// This class handles colorizing of terminal output.
class AnsiPen {
  const AnsiPen(this.color)
      : assert(
          color == null || color >= 0 && color <= 255,
          'Color must be between 0 and 255',
        );

  const AnsiPen.none() : color = null;

  const AnsiPen.white() : color = 255;
  const AnsiPen.black() : color = 232;
  const AnsiPen.red() : color = 196;
  const AnsiPen.orange() : color = 208;
  const AnsiPen.purple() : color = 199;
  const AnsiPen.gold() : color = 220;
  const AnsiPen.blue() : color = 39;
  const AnsiPen.navyBlue() : color = 17;
  const AnsiPen.green() : color = 40;
  const AnsiPen.darkRed() : color = 88;
  const AnsiPen.darkGreen() : color = 28;
  const AnsiPen.darkYellow() : color = 136;
  const AnsiPen.darkBlue() : color = 21;
  const AnsiPen.darkPurple() : color = 90;
  const AnsiPen.lightPurple() : color = 213;
  const AnsiPen.lightGreen() : color = 47;
  const AnsiPen.lightYellow() : color = 228;
  const AnsiPen.lightBlue() : color = 45;
  const AnsiPen.gray() : color = 243;
  const AnsiPen.darkGray() : color = 236;
  const AnsiPen.lightGray() : color = 250;
  const AnsiPen.beige() : color = 230;
  const AnsiPen.brown() : color = 130;
  const AnsiPen.pink() : color = 218;
  const AnsiPen.lightRed() : color = 201;
  const AnsiPen.yellow() : color = 226;
  const AnsiPen.cyan() : color = 51;

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
