// ignore_for_file: avoid_redundant_argument_values

import 'package:proxima_logger/proxima_logger.dart';

LogSettings _settingsBuilder(ILogType logType) => switch (logType) {
      LogType.debug => const LogSettings(
          logParts: [
            LogPart.stack,
            LogPart.time,
            LogPart.message,
          ],
          logDecorations: LogDecorations.rounded(),
        ),
      LogType.warning => const LogSettings(
          logDecorations: LogDecorations.rounded(),
        ),
      LogType.error => const LogSettings(
          logDecorations: LogDecorations.thick(),
        ),
      LogType.wtf || LogType.nothing => const LogSettings(
          logDecorations: LogDecorations.thin(),
        ),
      _ => const LogSettings(
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
    };

final logger = ProximaLogger(
  settings: _settingsBuilder,
  formatter: CustomFormatter(_settingsBuilder),
  decorator: CustomDecorator(_settingsBuilder),
  output: CustomOutput(_settingsBuilder),
);

class CustomFormatter implements ILogFormatter {
  CustomFormatter(this.settings);
  final SettingsBuilder settings;

  late final ILogFormatter _formatter = LogFormatter(settings);

  @override
  FormattedLogEvent format(LogEvent event) {
    return _formatter.format(event);
  }
}

class CustomDecorator implements ILogDecorator {
  CustomDecorator(this.settings);
  final SettingsBuilder settings;

  late final ILogDecorator _decorator = LogDecorator(settings);

  @override
  List<String> decorate(FormattedLogEvent event) {
    return _decorator.decorate(event);
  }
}

class CustomOutput implements ILogOutput {
  CustomOutput(this.settings);
  final SettingsBuilder settings;

  late final ILogOutput _output = ConsoleOutput();

  @override
  void output(OutputEvent outputEvent) {
    _output.output(outputEvent);
  }
}
