import 'dart:convert';
import 'dart:io' show HttpStatus;

import 'package:http/http.dart' as http;

import '../../domain/gateways/questions_gateway.dart';
import '../../domain/models/questions_model.dart';
import '../helpers/questions.dart';
import '../helpers/url_setter.dart';
import '../mappers/questions_mapper.dart';

class QuestionsApi extends QuestionsGateway {

  final Map<String, String> reqHeaders = {
    'Content-type': 'application/json',
  };

  @override
  Future<Questions> getQuestions(
    int amount,
    int category, 
    String difficulty,
    String type
    ) async {
    final Uri url = Uri.parse(UrlSetter.urlSetter(
      amount,
      category,
      difficulty,
      type,
      QuestionsCore.questionsApi
    ));
    final http.Response resp = await http.get(url, headers: reqHeaders);

    if(resp.statusCode == HttpStatus.ok) {
      final data = QuestionsMapper().fromMap(jsonDecode(resp.body));
      return data;
    } else {
      throw Exception('There has been an error with the http request to: $url');
    }
  }

}