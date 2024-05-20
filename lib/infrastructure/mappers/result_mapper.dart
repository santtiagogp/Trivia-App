import '../../domain/models/questions_model.dart';
import '../helpers/base64_decoder.dart';
import '../helpers/mapper.dart';

class ResultMapper extends Mapper<Result> {
  @override
  Result fromMap(Map<String, dynamic> json) => Result(
    type: CustomBase64Decoder.base64Decoder(json['type']),
    difficulty: CustomBase64Decoder.base64Decoder(json['difficulty']),
    category: CustomBase64Decoder.base64Decoder(json['category']),
    question: CustomBase64Decoder.base64Decoder(json['question']),
    correctAnswer: CustomBase64Decoder.base64Decoder(json['correct_answer']),
    incorrectAnswers: List<String>.from(
      json["incorrect_answers"].map((x) => CustomBase64Decoder.base64Decoder(x))
    )
  );

  @override
  Map<String, dynamic> toMap(Result data) => throw UnimplementedError();

}