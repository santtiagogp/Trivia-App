import 'package:flutter/material.dart';

import '../start_screen/start_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Welcome to TriviApp', style: TextStyle(
                fontSize: 25
              ),),
              const Align(
                alignment: Alignment.center,
                child: Text('Take trivias about multiple topics with different difficulties')
              ),
              const Text('Tap here to'),
              OutlinedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StartScreen()
                  )
                ),
                child: const Text('Start')
              )
            ],
          ),
        ),
      ),
    );
  }
}