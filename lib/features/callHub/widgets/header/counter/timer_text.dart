import 'dart:async';

import 'package:catfish_mobile/utils/formatters/formate_secondes_to_string.dart';
import 'package:flutter/material.dart';

class TimerText extends StatefulWidget {
  const TimerText({super.key});

  @override
  State<TimerText> createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
  late Timer _timer;
  int _timerValue = 0;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timerValue++;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formateSecondesToString(_timerValue),
      style: TextStyle(
        color: Colors.white70,
      ),
    );
  }
}
