import '../../domain/models/questions_model.dart';
import '../helpers/mapper.dart';
import 'result_mapper.dart';

class QuestionsMapper extends Mapper<Questions> {
  @override
  Questions fromMap(Map<String, dynamic> json) => Questions(
    responseCode: json['response_code'],
    results: List<Result>.from(json["results"].map((x) => ResultMapper().fromMap(x))),
  );

  @override
  Map<String, dynamic> toMap(Questions data) => throw UnimplementedError();

}