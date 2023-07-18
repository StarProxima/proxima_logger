import 'package:proxima_logger/proxima_logger.dart';

const _logTypeSettings = LogTypeSettings(
  LogSettings(
    logParts: [
      LogPart.stack,
      LogPart.error,
      LogPart.time,
      LogPart.divider,
      LogPart.message,
    ],
    printEmoji: true,
    printTitle: true,
    printLogTypeLabel: true,
  ),
  {
    LogType.debug: LogSettings(
      logParts: [
        LogPart.stack,
        LogPart.time,
        LogPart.message,
      ],
      logDecorations: LogDecorations.rounded(),
    ),
    LogType.warning: LogSettings(
      logDecorations: LogDecorations.rounded(),
    ),
    LogType.error: LogSettings(
      logDecorations: LogDecorations.thick(),
    ),
    LogType.wtf: LogSettings(
      logDecorations: LogDecorations.thin(),
    ),
  },
);

final logger = ProximaLogger(
  settings: _logTypeSettings.settings,
  typeSettings: _logTypeSettings.typeSettings,
  formatter: CustomFormatter(_logTypeSettings),
  decorator: CustomDecorator(_logTypeSettings),
  output: CustomOutput(_logTypeSettings),
);

class CustomFormatter implements ILogFormatter {
  final LogTypeSettings settings;

  CustomFormatter(this.settings);

  late final ILogFormatter _formatter = LogFormatter(settings);

  @override
  FormattedLogEvent format(LogEvent event) {
    return _formatter.format(event);
  }
}

class CustomDecorator implements ILogDecorator {
  final LogTypeSettings settings;

  CustomDecorator(this.settings);

  late final ILogDecorator _decorator = LogDecorator(settings);

  @override
  List<String> decorate(FormattedLogEvent event) {
    return _decorator.decorate(event);
  }
}

class CustomOutput implements LogOutput {
  final LogTypeSettings settings;

  CustomOutput(this.settings);

  late final LogOutput _output = ConsoleOutput();

  @override
  void output(OutputEvent outputEvent) {
    _output.output(outputEvent);
  }
}
