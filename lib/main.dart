import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/use_cases/questions_use_case.dart';
import 'infrastructure/driven_adapters/questions_api.dart';
import 'ui/screens/home_screen/home_screen.dart';
import 'ui/screens/notifiers/questions_notifier/questions_notifier.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuestionsNotifier(QuestionsUseCases(QuestionsApi())),
      child: const MaterialApp(
        home: HomeScreen()
      ),
    );
  }
}
