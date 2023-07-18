import '../../support/log_settings.dart';
import '../../support/log_type.dart';

/// A [IStackTraceFormatter] formats a [StackTrace].
abstract class IStackTraceFormatter {
  String? format(ILogType log, StackTrace? stackTrace, {required bool isError});
}

/// Default implementation of [StackTraceFormatter]. Removes unnecessary lines in the [StackTrace].
class StackTraceFormatter implements IStackTraceFormatter {
  const StackTraceFormatter(this.settings);

  final SettingsBuilder settings;

  /// Matches a stacktrace line as generated on Android/iOS devices.
  static final _deviceStackTraceRegex =
      RegExp(r'#[0-9]+[\s]+(.+) \(([^\s]+)\)');

  /// Matches a stacktrace line as generated by Flutter web.
  static final _webStackTraceRegex =
      RegExp(r'^((packages|dart-sdk)\/[^\s]+\/)');

  /// Matches a stacktrace line as generated by browser Dart.
  static final _browserStackTraceRegex =
      RegExp(r'^(?:package:)?(dart:[^\s]+|[^\s]+)');

  static bool _discardDeviceStacktraceLine(String line) {
    var match = _deviceStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    return match.group(2)!.startsWith('package:flutter') ||
        match.group(2)!.startsWith('dart:');
  }

  static bool _discardWebStacktraceLine(String line) {
    var match = _webStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }

    return line.contains('packages/proxima_logger') ||
        match.group(1)!.startsWith('dart-sdk/lib');
  }

  static bool _discardBrowserStacktraceLine(String line) {
    var match = _browserStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }

    return line.contains('package:proxima_logger') ||
        match.group(1)!.startsWith('dart:');
  }

  String? format(ILogType log, StackTrace? stackTrace,
      {required bool isError}) {
    List<String> lines = stackTrace.toString().split('\n');
    if (!isError &&
        settings(log).stackTraceBeginIndex > 0 &&
        settings(log).stackTraceBeginIndex < lines.length - 1) {
      lines = lines.sublist(settings(log).stackTraceBeginIndex);
    }
    List<String> formatted = [];
    int count = 0;
    for (var line in lines) {
      if (_discardDeviceStacktraceLine(line) ||
          _discardWebStacktraceLine(line) ||
          _discardBrowserStacktraceLine(line) ||
          line.isEmpty) {
        continue;
      }
      formatted.add(
          '#$count   ${line.replaceFirst(RegExp(r'#\d+\s+'), '').replaceAll('.<anonymous closure>', '()')}');
      if (isError) {
        if (++count >= settings(log).errorStackTraceMethodCount) {
          break;
        }
      } else {
        if (++count >= settings(log).stackTraceMethodCount) {
          break;
        }
      }
    }

    if (formatted.isEmpty) {
      return null;
    } else {
      return formatted.join('\n');
    }
  }
}
