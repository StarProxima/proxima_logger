import 'dart:async';

import 'package:flutter/material.dart';

import 'error_handler.dart';
import 'large_nesting_widget.dart';
import 'logger/proxima_logger.dart';
import 'model.dart';

void main() {
  runZonedGuarded(
    () {
      ErrorHandler.init();
      runApp(const MyApp());
    },
    ErrorHandler.recordError,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool b = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                logger.log(
                  Log.info,
                  title:
                      'Крик души не покинет стены Цитадели. Перед смертью вопрос: что же я наделал? На коленях стою и разбита Скорбь. ',
                );
              },
              child: const Text('info'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                logger.log(
                  Log.debug,
                  message: 'Debug message',
                );
              },
              child: const Text('debug'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                logger.log(
                  Log.warning,
                  error: Exception('warning'),
                );
              },
              child: const Text('warning'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                try {
                  throw Exception('Error');
                } catch (e, s) {
                  logger.log(
                    Log.error,
                    title: 'ElevatedButton error',
                    error: e,
                    stack: s,
                  );
                }
              },
              child: const Text('error'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                logger.log(
                  Log.wtf,
                );
              },
              child: const Text('wtf'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                logger.log(
                  Log.wtf,
                  title: 'Task json',
                  message: Task.random().toMap(),
                );
              },
              child: const Text('json'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  b = !b;
                });
              },
              child: const Text('exception'),
            ),
            if (b) const LargeNestingWidget(),
          ],
        ),
      ),
    );
  }
}
