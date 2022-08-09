import 'dart:developer';

import 'package:flutter/material.dart';

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
                log('message0');
              },
              child: const Text('Button0'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                log('message1');
              },
              child: const Text('Button1'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                log('message2');
              },
              child: const Text('Button2'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                log('message3');
              },
              child: const Text('Button3'),
            ),
          ],
        ),
      ),
    );
  }
}
