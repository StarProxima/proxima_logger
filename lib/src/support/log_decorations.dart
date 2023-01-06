class LogDecorations {
  /// The top left corner of the log.
  final String topLeftCorner;

  /// The bottom left corner of the log.
  final String bottomLeftCorner;

  /// The middle corner of the log.
  final String middleCorner;

  /// The middle top corner of the log.
  final String middleTopCorner;

  /// The vertical line of the log.
  final String verticalLine;

  /// The divider of the log.
  final String divider;

  /// The middle divider of the log.
  final String middleDivider;

  /// Creates a new custom [LogDecorations] instance.
  const LogDecorations.custom({
    required this.topLeftCorner,
    required this.bottomLeftCorner,
    required this.middleCorner,
    required this.middleTopCorner,
    required this.verticalLine,
    required this.divider,
    required this.middleDivider,
  });

  /// Creates a new [LogDecorations] instance with thin borders.
  const LogDecorations.thin()
      : topLeftCorner = '┌',
        bottomLeftCorner = '└',
        middleCorner = '├',
        middleTopCorner = '┤',
        verticalLine = '│',
        divider = '─',
        middleDivider = '┄';

  /// Creates a new [LogDecorations] instance with thick borders.
  const LogDecorations.thick()
      : topLeftCorner = '╔',
        bottomLeftCorner = '╚',
        middleCorner = '╠',
        middleTopCorner = '╣',
        verticalLine = '║',
        divider = '═',
        middleDivider = '╌';

  /// Creates a new [LogDecorations] instance with rounded borders.
  const LogDecorations.rounded()
      : topLeftCorner = '╭',
        bottomLeftCorner = '╰',
        middleCorner = '├',
        middleTopCorner = '┤',
        verticalLine = '│',
        divider = '─',
        middleDivider = '┄';
}
