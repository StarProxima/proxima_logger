import 'dart:convert';

/// A [MessageFormatter] formats a dynamic message into a [String].
abstract class MessageFormatter {
  String format(dynamic message);

  /// Default implementation of [MessageFormatter].
  factory MessageFormatter() => _DefaultMessageFormatter();
}

class _DefaultMessageFormatter implements MessageFormatter {
  // Handles any object that is causing JsonEncoder() problems
  Object toEncodableFallback(dynamic object) {
    return object.toString();
  }

  String format(dynamic message) {
    final finalMessage = message is Function ? message() : message;
    if (finalMessage is Map || finalMessage is Iterable) {
      var encoder = JsonEncoder.withIndent('  ', toEncodableFallback);
      return encoder.convert(finalMessage);
    } else {
      return finalMessage.toString();
    }
  }
}
