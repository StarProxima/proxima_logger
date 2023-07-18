import 'package:proxima_logger/proxima_logger.dart';
import 'package:test/test.dart';

void main() {
  test('Test formatting of log event with default settings', () {
    var formatter = LogFormatter(
      (_) => LogSettings(),
    );
    var logEvent = LogEvent(LogType.warning,
        title: 'Test log event', time: DateTime.now());
    var formattedLogEvent = formatter.format(logEvent);

    expect(formattedLogEvent.log, equals(LogType.warning));
    expect(
        formattedLogEvent.queue,
        equals([
          LogPart.stack,
          LogPart.time,
        ]));
    expect(formattedLogEvent.title, isNotNull);
    expect(formattedLogEvent.error, isNull);
    expect(formattedLogEvent.stack, isNotNull);
    expect(formattedLogEvent.time, isNotNull);
    expect(formattedLogEvent.title, equals('Test log event'));
  });

  test('Test formatting of log event with custom settings', () {
    var settings = LogSettings(
      logParts: [
        LogPart.time,
        LogPart.message,
      ],
      printTimeSinceStartInTime: false,
      printEmoji: false,
    );

    var formatter = LogFormatter((_) => settings);
    var logEvent = LogEvent(
      LogType.warning,
      title: 'Test log event',
      message: 'Test log event message',
      time: DateTime.now(),
    );

    var formattedLogEvent = formatter.format(logEvent);

    expect(formattedLogEvent.log, equals(LogType.warning));
    expect(
        formattedLogEvent.queue,
        equals([
          LogPart.time,
          LogPart.message,
        ]));

    expect(formattedLogEvent.title, isNotNull);
    expect(formattedLogEvent.error, isNull);
    expect(formattedLogEvent.stack, isNull);
    expect(formattedLogEvent.time, isNotNull);
    expect(formattedLogEvent.message, equals('Test log event message'));
  });
}
