import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:musiq_front/models/question_model.dart';

class ApiService {
  // TODO: 수정 예정
  static const String baseUrl = 'https://seungdev.com';
  // TODO: restAPI 따라 뒤이은 도메인 추가 예정

  /// 사용자 질문들 받기. 각 질문의 대답들은 따로 받음.
  static Future<List<QuestionModel>> getQuestions() async {
    List<QuestionModel> questionInstances = [];
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> questions = jsonDecode(response.body);
      for (var question in questions) {
        questionInstances.add(QuestionModel.fromJson(question));
      }
      return questionInstances;
    }
    throw Error();
  }
}
