import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifiers/questions_notifier/questions_notifier.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  bool timeCompleted = false;

  static late AudioPlayer _player;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<QuestionsNotifier>().setCurrentAnswers();
    });
    AudioCache.instance = AudioCache(prefix: '');
    _player = AudioPlayer();
    playAudio();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15)
    )..addStatusListener((status) {
      if( status == AnimationStatus.completed ) {
        timeCompleted = true;
        stopAudio();
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

    final qProvider = Provider.of<QuestionsNotifier>(context, listen: true);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Question #${qProvider.currentQuestion}'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LinearProgressIndicator(
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
                  return TextButton(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.zero)
                    ),
                    onPressed: () {
                      
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade200,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          qProvider.currentAnswers[index],
                          style: const TextStyle(
                            color: Colors.white
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
      )
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}