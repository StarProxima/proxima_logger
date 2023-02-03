
![proxima_logger_logo](https://user-images.githubusercontent.com/34741787/209454108-6b945ace-d084-46c6-bc0c-95b5cf9cb8dd.jpg)

**Easy to use, customizable, expandable logger that prints beautiful logs.**

💎 **Proxima Logger** - the of logging package for your Flutter / Dart app. ✨ With its beautiful and intuitive design, you'll be up and running in no time.

🎨 Customize your logs to your heart's desire with a range of options and styles. 🐛 Need to print out debug messages? No problem. 🌈 Want to add some color to your logs to make them stand out? **Proxima Logger** has you covered.

🚀 But that's not all - Flutter Logging is also highly extensible. 🌍 Need to send your logs to a remote server for safekeeping? **Proxima Logger** makes it possible to integrate with your preferred logging backend. Plus, it's easy to output logs from popular HTTP clients such as Dio.

🙌 In addition, **Proxima Logger** has no dependencies, meaning it won't add any extra weight to your app or introduce any additional vulnerabilities.

## Getting started

1. Add package to the project:
    ```yaml
    dependencies:
        proxima_logger: ^0.6.2
    ```

2. Create an instance of Proxima Logger. You can set general settings for logging, including the order in which parts of the log are output, the style of the borders, and more if you like.
   ```dart
    final logger = MyLogger(
        settings: const LogSettings(
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
        typeSettings: {
            Log.warning: const LogSettings(
                logDecorations: LogDecorations.rounded(),
            ),
            Log.error: const LogSettings(
                logDecorations: LogDecorations.thick(),
            ),
        },
    );
   ```

# Usage
   Use logger.log() anywhere in the program.
```dart
logger.log(
    Log.info,
    title: 'Log title',
);

logger.log(
    Log.debug,
    message: 'Debug message',
);

try {
    //...
} catch (e, s) {
    logger.log(
        Log.error,
        title: 'Some error',
        error: e,
        stack: s,
    );
}
```
# Notes

To handle errors automatically, add runZonedGuarded() to main().
```dart
void main() {
  void recordError(Object error, StackTrace stackTrace) {
    logger.log(Log.error, error: error, stack: stackTrace);
  }

  void recordFlutterError(FlutterErrorDetails error) {
    logger.log(Log.error, error: error, stack: error.stack);
  }

  runZonedGuarded(
    () {
      FlutterError.onError = recordFlutterError;
      runApp(const MyApp());
    },
    recordError,
  );
}
```

You can write your own wrapper over the logger to quickly use the required logging types and conveniently log requests from an http client, such as Dio.
```dart
class MyLogger extends ProximaLogger {
  MyLogger({
    super.settings,
    super.typeSettings,
    super.formatter,
    super.decorator,
    super.output,
  });

  void info(String message) {
    log(Log.info, message: message);
  }

  void error(Error error, StackTrace stack, [String? message]) {
    log(Log.error, error: error, stack: stack, message: message);
  }

  void response(Response response) {
    log(
      Log.response,
      title:
          '| ${response.requestOptions.method} | ${response.statusCode} | ${response.requestOptions.path}',
      message: response.data,
    );
  }
}
```

If necessary, you can implement the LogType class and create your own log types.
```dart
enum Log implements LogType {
  custom(
    label: 'custom',
    emoji: '🦄',
    ansiPen: AnsiPen.purple(),
  );

  @override
  final String label;
  @override
  final String emoji;
  @override
  final AnsiPen ansiPen;
  @override
  final AnsiPen ansiPenOnBackground;

  const Log({
    required this.label,
    required this.emoji,
    required this.ansiPen,
    this.ansiPenOnBackground = const AnsiPen.black(),
  });
}
```

    
## Output
![image](https://user-images.githubusercontent.com/34741787/209454127-c54c1f06-31a7-4be6-bcb2-ddc976c08b8b.png)
![image](https://user-images.githubusercontent.com/34741787/209454129-aa26cb15-f3f5-46d0-a56c-5a7f746e62b6.png)

