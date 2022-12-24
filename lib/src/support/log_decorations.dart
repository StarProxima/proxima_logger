class LogDecorations {
  /// The length of the line.
  final int lineLength;

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

  /// The divider line of the log.
  final String dividerLine;

  /// The middle divider line of the log.
  final String middleDividerLine;

  /// Creates a new custom [LogDecorations] instance.
  const LogDecorations.custom(
    this.lineLength, {
    required this.topLeftCorner,
    required this.bottomLeftCorner,
    required this.middleCorner,
    required this.middleTopCorner,
    required this.verticalLine,
    required this.divider,
    required this.middleDivider,
  })  : dividerLine = divider * lineLength,
        middleDividerLine = middleDivider * lineLength;

  /// Creates a new [LogDecorations] instance with thin borders.
  const LogDecorations.thin(this.lineLength)
      : topLeftCorner = '┌',
        bottomLeftCorner = '└',
        middleCorner = '├',
        middleTopCorner = '┤',
        verticalLine = '│',
        divider = '─',
        middleDivider = '┄',
        dividerLine = '─' * lineLength,
        middleDividerLine = '┄' * lineLength;

  /// Creates a new [LogDecorations] instance with thick borders.
  const LogDecorations.thick(this.lineLength)
      : topLeftCorner = '╔',
        bottomLeftCorner = '╚',
        middleCorner = '╠',
        middleTopCorner = '╣',
        verticalLine = '║',
        divider = '═',
        middleDivider = '╌',
        dividerLine = '═' * lineLength,
        middleDividerLine = '╌' * lineLength;

  /// Creates a new [LogDecorations] instance with rounded borders.
  const LogDecorations.rounded(this.lineLength)
      : topLeftCorner = '╭',
        bottomLeftCorner = '╰',
        middleCorner = '├',
        middleTopCorner = '┤',
        verticalLine = '│',
        divider = '─',
        middleDivider = '┄',
        dividerLine = '─' * lineLength,
        middleDividerLine = '┄' * lineLength;
}
