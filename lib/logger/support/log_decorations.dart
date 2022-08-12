class LogDecorations {
  LogDecorations(
    this.lineLength, {
    this.topLeftCorner = '┌',
    this.bottomLeftCorner = '└',
    this.middleCorner = '├',
    this.middleTopCorner = '┤',
    this.verticalLine = '│',
    this.divider = '─',
    this.middleDivider = '┄',
  }) {
    _initLogDecorate();
  }

  LogDecorations.thick(this.lineLength)
      : topLeftCorner = '╔',
        bottomLeftCorner = '╚',
        middleCorner = '╠',
        middleTopCorner = '╣',
        verticalLine = '║',
        divider = '═',
        middleDivider = '╌' {
    _initLogDecorate();
  }

  LogDecorations.rounded(this.lineLength)
      : topLeftCorner = '╭',
        bottomLeftCorner = '╰',
        middleCorner = '├',
        middleTopCorner = '┤',
        verticalLine = '│',
        divider = '─',
        middleDivider = '┄' {
    _initLogDecorate();
  }

  void _initLogDecorate() {
    var doubleDividerLine = StringBuffer();
    var singleDividerLine = StringBuffer();
    for (var i = 0; i < lineLength - 1; i++) {
      doubleDividerLine.write(divider);
      singleDividerLine.write(middleDivider);
    }
    dividerLine = '$doubleDividerLine';
    middleDividerLine = '$singleDividerLine';
  }

  final int lineLength;
  final String topLeftCorner;
  final String bottomLeftCorner;
  final String middleCorner;
  final String middleTopCorner;
  final String verticalLine;
  final String divider;
  final String middleDivider;

  late final String dividerLine;
  late final String middleDividerLine;
}
