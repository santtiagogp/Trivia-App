import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifiers/questions_notifier/questions_notifier.dart';
import '../start_screen/start_screen.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {

  late ConfettiController confettiController;

  @override
  void initState() {
    confettiController = ConfettiController();
    confettiController.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final qProvider = Provider.of<QuestionsNotifier>(context);

    return PopScope(
      canPop: false,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text('Final Results!'),
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Total questions: ${qProvider.questions.length}',
                    style: const TextStyle(
                      fontSize: 18,
                    )
                  ),
                  Text(
                    'Correct answers: ${qProvider.correctAnswers}',
                    style: const TextStyle(
                      fontSize: 18,
                    )
                  ),
                  Text(
                    'Incorrect answers: ${qProvider.wrongAnswers}',
                    style: const TextStyle(
                      fontSize: 18,
                    )
                  ),
                  Text(
                    'Final Score: ${qProvider.finalScore}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  OutlinedButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          qProvider.resetAllValues();
                          qProvider.resetScore();
                          return const StartScreen();
                        },
                      )
                    ),
                    child: const Text('Play again')
                  )
                ],
              ),
            ),
          ),
          ConfettiWidget(
            confettiController: confettiController,
            shouldLoop: true,
            blastDirection: pi / 2,
            blastDirectionality: BlastDirectionality.explosive,
            minBlastForce: 8,
            maxBlastForce: 10,
            emissionFrequency: 0.03,
            numberOfParticles: 9,
          )
        ],
      ),
    );
  }
}