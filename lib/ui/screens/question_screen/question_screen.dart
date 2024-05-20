import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifiers/questions_notifier/questions_notifier.dart';
import '../results_screen/results_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  bool timeCompleted = false;
  int? selectedAnswerIndex;
  bool? isCorrect;
  bool confettiIsPlaying = false;
  late ConfettiController _confettiController;

  static late AudioPlayer _player;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<QuestionsNotifier>().setCurrentAnswers();
    });
    AudioCache.instance = AudioCache(prefix: '');
    _confettiController = ConfettiController();
    _player = AudioPlayer();
    playAudio();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15)
    )..addStatusListener((status) {
      if( status == AnimationStatus.completed ) {
        timeCompleted = true;
        stopAudio();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              context.read<QuestionsNotifier>().moveToNextQuestion();
              return const QuestionScreen();
            },
          )
        );
      }
    },)..addListener(() {
      setState((){});
    });

    _controller.forward();
    super.initState();
  }

  void playAudio() async {
    _player.setVolume(1);
    _player.setReleaseMode(ReleaseMode.loop);
    await _player.play(AssetSource('assets/clock.mp3'));
  }

  void stopAudio() async {
    await _player.stop();
  }

  @override
  Widget build(BuildContext context) {

    final qProvider = Provider.of<QuestionsNotifier>(context, listen: false);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Question #${qProvider.currentQuestion}'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LinearProgressIndicator(
                  minHeight: 10,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.pink.shade100,
                  value: _controller.value,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(qProvider.questions[qProvider.currentQuestion - 1].question,
                    style: const TextStyle(
                      fontSize: 25,
                  ), textAlign: TextAlign.center,),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: GridView.builder(
                    itemCount: qProvider.currentAnswers.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / .8)
                    ),
                    itemBuilder: (context, index) {
                      Color tileColor = Colors.purple.shade200;
                      if (selectedAnswerIndex != null) {
                        if (selectedAnswerIndex == index) {
                          tileColor = isCorrect == true ? Colors.green : Colors.red;
                        }
                      }
                      return TextButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(EdgeInsets.zero)
                        ),
                        onPressed: selectedAnswerIndex == null ? () {
                          _controller.stop();
                          stopAudio();
                          setState(() {
                            selectedAnswerIndex = index;
                            isCorrect = qProvider.currentAnswers[index] == qProvider.currentCorrectAnswer;
                          });

                          if (isCorrect == true) {
                            qProvider.addCorrectAnswers();
                            qProvider.addPoints();
                            _confettiController.play();
                          } else {
                            qProvider.addWrongAnswers();
                          }
            
                          Future.delayed(const Duration(milliseconds: 3000), () {
                            if (qProvider.isLastQuestion) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const ResultsScreen();
                                  },
                                )
                              );
                            } else {
                              setState(() {
                                selectedAnswerIndex = null;
                                isCorrect = null;
                              });
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    qProvider.moveToNextQuestion();
                                    return const QuestionScreen();
                                  },
                                )
                              );
                            }
                          });
                        } : null,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: tileColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              qProvider.currentAnswers[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  )
                )
              ],
            ),
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              numberOfParticles: 20,
              blastDirectionality: BlastDirectionality.explosive,
            )
          ],
        ),
      )
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _controller.dispose();
    super.dispose();
  }

}