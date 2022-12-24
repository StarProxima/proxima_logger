**Easy to use, customizable, expandable logger that prints beautiful logs**

## Getting started

1. Add package to the project:
    ```yaml
    dependencies:
        proxima_logger: ^0.5.0
    ```

2. Create an instance of ProximaLogger and set the settings as needed:
   ```dart
    final logger = ProximaLogger(
        settings: LogSettings(
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
            Log.warning: LogSettings(
                logParts: [
                    LogPart.stack,
                    LogPart.message,
                ],
                printEmoji: false,
            ),
        },
    );
   ```

3. If necessary, you can implement the LogType class and create your own log types.
    ```dart
    enum Log implements LogType {
        info,
        custom;

        @override
        String get label {
            switch (this) {
            case Log.info:
                return 'info';
            case Log.custom:
                return 'custom';
            }
        }

        @override
        String get emoji {
            switch (this) {
            case Log.info:
                return '💡';
            case Log.custom:
                return '🦄';
            }
        }

        @override
        AnsiPen get ansiPen {
            switch (this) {
            case Log.info:
                return AnsiPen.none();
            case Log.custom:
                return AnsiPen.purple();
            }
        }

        @override
        AnsiPen get ansiPenOnBackground {
            return AnsiPen.black();
        }
    }
    ```

## Usage
1. Use logger.log() anywhere in the program.
    ```dart
    logger.log(
        Log.info,
        title: 'Log title',
    );

    logger.log(
        Log.debug,
        message: 'Debug message'
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

2. Or write your own wrapper over logger for convenience.
    ```dart
    final logger = MyLogger();

    class MyLogger extends ProximaLogger {
        MyLogger({super.settings, super.typeSettings});

        void info(String message) {
            log(Log.info, message: message);
        }

        void error(Error error, StackTrace stack, [String? message]) {
            log(Log.error, error: error, stack: stack, message: message);
        }

        void response(Response response) {
            log(
                Log.response,
                title: '| ${response.requestOptions.method} | ${response.statusCode} | ${response.requestOptions.path}',
                message: response.data,
            );
        }
    }
    ```