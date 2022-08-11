import 'package:flutter/material.dart';

import 'large_nesting_widget.dart';
import 'logger/proxima_logger.dart';

void main() {
  runApp(const MyApp());
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
                  'info',
                  LogType.info,
                );
              },
              child: const Text('info'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                logger.log(
                  'debug',
                  LogType.debug,
                  'Title',
                  Exception('Error'),
                );
              },
              child: const Text('debug'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                logger.log(
                  'error',
                  LogType.error,
                  'Title',
                  Exception('Error'),
                );
              },
              child: const Text('error'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                logger.log(
                  'wtf',
                  LogType.wtf,
                  'Title',
                  Exception('Error'),
                );
              },
              child: const Text('wtf'),
            ),
            const SizedBox(height: 10),
            const LargeNestingWidget(),
          ],
        ),
      ),
    );
  }
}
