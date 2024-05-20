import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../notifiers/questions_notifier/questions_notifier.dart';
import '../../../domain/use_cases/questions_use_case.dart';
import '../question_screen/question_screen.dart';

class CountdownScreen extends StatefulWidget {
  const CountdownScreen({
    super.key,
    required this.numberOfQuestions,
    required this.difficulty,
    required this.category,
    required this.type,
    required this.useCases
  });

  final int numberOfQuestions;
  final String difficulty;
  final int category;
  final String type;
  final QuestionsUseCases useCases;

  @override
  State<CountdownScreen> createState() => _CountdownPageScreen();
}

class _CountdownPageScreen extends State<CountdownScreen> {
  int _currentNumber = 3;
  late Timer _timer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuestionsNotifier>().getQuestions(
        widget.numberOfQuestions,
        widget.category,
        widget.difficulty,
        widget.type
      );
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentNumber > 0) {
        setState(() {
          _currentNumber--;
        });
      } else {
        _timer.cancel();
        SystemSound.play(SystemSoundType.click);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const QuestionScreen()),
        );
      }
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
    SystemSound.play(SystemSoundType.click);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child)
              );
            },
            child: Text(
              '$_currentNumber',
              key: ValueKey<int>(_currentNumber),
              style: const TextStyle(fontSize: 100, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
