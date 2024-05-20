import 'package:flutter/material.dart';
import '../../../domain/use_cases/questions_use_case.dart';
import '../../../infrastructure/driven_adapters/questions_api.dart';

import '../countdown_screen/countdown_screen.dart';
import 'utils/selections.dart';
import 'utils/string_to_num_map.dart';
import 'widgets/selection_widget.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int numberOfQuestions = 0;

  String difficulty = '';

  int category = 0;

  String type = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Make your selections'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: SelectionWidget(
                  title: 'Number of questions',
                  items: Selections.numberOfQuestions,
                  onSelection: (value) => numberOfQuestions = int.parse(value)
                )
              ),
              Center(
                child: SelectionWidget(
                  title: 'Difficulty',
                  items: Selections.difficulties,
                  onSelection: (value) => difficulty = value.toLowerCase(),
                )
              ),
              Center(
                child: SelectionWidget(
                  title: 'Category',
                  items: Selections.categories,
                  onSelection: (value) => category = getVal(Selections.categoriesMap, value),
                )
              ),
              Center(
                child: SelectionWidget(
                  title: 'Type',
                  items: Selections.type,
                  onSelection: (value) => type = getVal(Selections.typeMap, value),
                )
              ),
              OutlinedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CountdownScreen(
                      numberOfQuestions: numberOfQuestions,
                      difficulty: difficulty,
                      category: category,
                      type: type,
                      useCases: QuestionsUseCases(QuestionsApi()),
                    ),
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