import 'package:flutter/material.dart';

import '../../../../domain/models/questions_model.dart';
import '../../../../domain/use_cases/questions_use_case.dart';

class QuestionsNotifier extends ChangeNotifier {

  QuestionsNotifier(this._useCase);

  final QuestionsUseCases _useCase;
  List<Result> _questions = [];
  List<String> _currentAnswers = [];
  String _currentCorrectAnswer = '';
  int _currentQuestionIndex = 0;
  bool _lastQuestion = false;

  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  int _finalScore = 0;

  List<Result> get questions => _questions;
  bool get isLastQuestion => _lastQuestion;
  int get currentQuestion => _currentQuestionIndex + 1;
  List<String> get currentAnswers => _currentAnswers;
  String get currentCorrectAnswer => _currentCorrectAnswer;
  int get correctAnswers => _correctAnswers;
  int get wrongAnswers => _wrongAnswers;
  int get finalScore => _finalScore;

  setCurrentAnswers() {

    List<String> answers = List.empty(growable: true);

    final correctAnswer = _questions[currentQuestion - 1].correctAnswer;

    _currentCorrectAnswer = correctAnswer;

    for (String answer in _questions[currentQuestion - 1].incorrectAnswers) {
      answers.add(answer);
    }
    answers.add(correctAnswer);

    answers.shuffle();

    _currentAnswers = answers;
  }


  void getQuestions(
    int amount,
    int category, 
    String difficulty,
    String type
  ) async {

    try {
      final resp = await _useCase.getQuestions(amount, category, difficulty, type);
      _questions = resp.results;
    } catch (e) {
      throw Exception(e);
    }

  }

  void moveToNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _lastQuestion = _currentQuestionIndex == _questions.length - 1;
      setCurrentAnswers();
    } else {
      _lastQuestion = true;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void resetAllValues() {
    _questions = [];
    _currentAnswers = [];
    _currentCorrectAnswer = '';
    _currentQuestionIndex = 0;
    _lastQuestion = false;
  }

  void addPoints() {
    _finalScore += 100;
    notifyListeners();
  }

  void addCorrectAnswers() => _correctAnswers++;
  
  void addWrongAnswers() => _wrongAnswers++;

  void resetScore() {
    _finalScore = 0;
    _correctAnswers = 0;
    _wrongAnswers = 0;
  }

}