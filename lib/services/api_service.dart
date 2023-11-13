import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:musiq_front/models/question_model.dart';
import 'package:musiq_front/models/search_music_model.dart';

// TODO: ERROR 수신한 경우 팝업 혹은 다른 방식으로 알리기
class ApiService {
  static const String baseUrl = 'http://musiq-api.ap-northeast-2.elasticbeanstalk.com';
  static const String searchSong = 'search?search_text=';
  static const String questionListQuestions = 'question-list/questions?user_id=';
  static const String questionListAnswers = 'question-list/answers';

  /// Tab 2; 사용자 질문들 리스트 받기. 각 질문의 대답들은 따로 받음.
  /// 200: 대답했던 질문들 리스트로 바로 옴,
  /// 400: 에러
  static Future<List<QuestionModel>> getQuestionsListQuestions(String userId) async {
    List<QuestionModel> questionInstances = [];
    final url = Uri.parse("$baseUrl/$questionListQuestions$userId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> questions = jsonDecode(response.body);
      print(questions);
      for (var question in questions) {
        questionInstances.add(QuestionModel.fromJson(question));
      }
      return questionInstances;
    }
    throw Error();
  }

  /// 검색 결과 곡들 받기.
  /// 200: 검색된 곡들 리스트로 바로 옴.
  /// 400: 에러
  static Future<List<SearchMusicModel>> getSearchMusics(String searchText) async {
    List<SearchMusicModel> searchMusicInstances = [];
    final url = Uri.parse("$baseUrl/$searchSong$searchText");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> searchMusics = jsonDecode(response.body);
      print(searchMusics);
      for (var searchMusic in searchMusics) {
        searchMusicInstances.add(SearchMusicModel.fromJson(searchMusic));
      }
      return searchMusicInstances;
    }
    throw Error();
  }
}
