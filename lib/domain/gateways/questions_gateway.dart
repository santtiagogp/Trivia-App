import '../models/questions_model.dart';

abstract class QuestionsGateway {
  Future<Questions> getQuestions(
    int amount,
    int category,
    String difficulty,
    String type
  );
}