import 'dart:developer';

import 'package:flutter/material.dart';

import 'logger/proxima_logger.dart';

class LargeNestingWidget extends StatelessWidget {
  const LargeNestingWidget({Key? key}) : super(key: key);

  Widget _fun0() {
    return _fun1();
  }

  Widget _fun1() {
    return _fun2();
  }

  Widget _fun2() {
    return _fun3();
  }

  Widget _fun3() {
    return ElevatedButton(
      onPressed: () {
        logger.log(
          'LargeNestingWidget',
          LogType.wtf,
        );
        log('LargeNestingWidget');
      },
      child: const Text('LargeNestingWidget'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _NestingWidget1(
      child: ElevatedButton(
        onPressed: () {
          logger.log(
            'LargeNestingWidget',
            LogType.wtf,
          );
          log('LargeNestingWidget');
        },
        child: const Text('LargeNestingWidget'),
      ),
    );
  }
}

class _NestingWidget1 extends StatefulWidget {
  const _NestingWidget1({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<_NestingWidget1> createState() => _NestingWidget1State();
}

class _NestingWidget1State extends State<_NestingWidget1> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: widget.child,
    );
  }
}