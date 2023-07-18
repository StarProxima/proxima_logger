import 'package:proxima_logger/proxima_logger.dart';
import 'package:test/test.dart';

void main() {
  test('Test formatting of log event with default settings', () {
    final formatter = LogFormatter(
      (_) => LogSettings(),
    );
    final logEvent = LogEvent(
      LogType.warning,
      title: 'Test log event',
      time: DateTime.now(),
    );
    final formattedLogEvent = formatter.format(logEvent);

    expect(formattedLogEvent.log, equals(LogType.warning));
    expect(
      formattedLogEvent.queue,
      equals([
        LogPart.stack,
        LogPart.time,
      ]),
    );
    expect(formattedLogEvent.title, isNotNull);
    expect(formattedLogEvent.error, isNull);
    expect(formattedLogEvent.stack, isNotNull);
    expect(formattedLogEvent.time, isNotNull);
    expect(formattedLogEvent.title, equals('Test log event'));
  });

  test('Test formatting of log event with custom settings', () {
    final settings = LogSettings(
      logParts: [
        LogPart.time,
        LogPart.message,
      ],
      printTimeSinceStartInTime: false,
      printEmoji: false,
    );

    final formatter = LogFormatter((_) => settings);
    final logEvent = LogEvent(
      LogType.warning,
      title: 'Test log event',
      message: 'Test log event message',
      time: DateTime.now(),
    );

    final formattedLogEvent = formatter.format(logEvent);

    expect(formattedLogEvent.log, equals(LogType.warning));
    expect(
      formattedLogEvent.queue,
      equals([
        LogPart.time,
        LogPart.message,
      ]),
    );

    expect(formattedLogEvent.title, isNotNull);
    expect(formattedLogEvent.error, isNull);
    expect(formattedLogEvent.stack, isNull);
    expect(formattedLogEvent.time, isNotNull);
    expect(formattedLogEvent.message, equals('Test log event message'));
  });
}
