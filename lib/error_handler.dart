import 'package:flutter/foundation.dart';

import 'logger/proxima_logger.dart';

class ErrorHandler {
  static void init() {
    FlutterError.onError = ErrorHandler._recordFlutterError;
    logger.log('initErrorHandler');
  }

  static void recordError(Object error, StackTrace stackTrace) {
    logger.log(error, Log.error, null, error, stackTrace);
  }

  static void _recordFlutterError(FlutterErrorDetails error) {
    logger.log(error, Log.error, null, error.exception, error.stack);
  }

  const ErrorHandler._();
}
