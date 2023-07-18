import 'proxima_logger_base.dart';

/// Use instances of ProximaLogger to print log messages.
class ProximaLogger extends ProximaLoggerBase {
  ProximaLogger({
    super.settings,
    super.formatter,
    super.decorator,
    super.output,
  });

  /// Print [LogType.info] log messages.
  void info({
    String? title,
    dynamic error,
    StackTrace? stack,
    dynamic message,
  }) =>
      log(
        LogType.info,
        title: title,
        error: error,
        stack: stack,
        message: message,
      );

  /// Print [LogType.debug] log messages.
  void debug({
    String? title,
    dynamic error,
    StackTrace? stack,
    dynamic message,
  }) =>
      log(
        LogType.debug,
        title: title,
        error: error,
        stack: stack,
        message: message,
      );

  /// Print [LogType.warning] log messages.
  void warning({
    String? title,
    dynamic error,
    StackTrace? stack,
    dynamic message,
  }) =>
      log(
        LogType.warning,
        title: title,
        error: error,
        stack: stack,
        message: message,
      );

  /// Print [LogType.error] log messages.
  void error({
    String? title,
    dynamic error,
    StackTrace? stack,
    dynamic message,
  }) =>
      log(
        LogType.error,
        title: title,
        error: error,
        stack: stack,
        message: message,
      );

  /// Print [LogType.wtf] log messages.
  void wtf({
    String? title,
    dynamic error,
    StackTrace? stack,
    dynamic message,
  }) =>
      log(
        LogType.wtf,
        title: title,
        error: error,
        stack: stack,
        message: message,
      );
}
