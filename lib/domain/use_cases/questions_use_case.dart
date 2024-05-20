import '../gateways/questions_gateway.dart';
import '../models/questions_model.dart';

class QuestionsUseCases {
  QuestionsUseCases(this.questionsGateway);
  final QuestionsGateway questionsGateway;

  Future<Questions> getQuestions(
    int amount,
    int category, 
    String difficulty,
    String type
  ) => questionsGateway.getQuestions(amount, category, difficulty, type);
}