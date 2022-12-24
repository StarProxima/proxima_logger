import 'package:flutter/foundation.dart';

import '../logger.dart';

class ErrorHandler {
  static void init() {
    FlutterError.onError = ErrorHandler._recordFlutterError;
    logger.log(Log.info, title: 'ErrorHandler init');
  }

  static void recordError(Object error, StackTrace stackTrace) {
    logger.log(Log.error, error: error, stack: stackTrace);
  }

  static void _recordFlutterError(FlutterErrorDetails error) {
    logger.log(Log.error, error: error, stack: error.stack);
  }

  const ErrorHandler._();
}
