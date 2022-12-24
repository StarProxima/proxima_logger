class LogDecorations {
  final int lineLength;
  final String topLeftCorner;
  final String bottomLeftCorner;
  final String middleCorner;
  final String middleTopCorner;
  final String verticalLine;
  final String divider;
  final String middleDivider;

  final String dividerLine;
  final String middleDividerLine;

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
