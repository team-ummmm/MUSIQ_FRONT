import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:musiq_front/models/question_model.dart';
import 'package:musiq_front/models/search_music_model.dart';

class ApiService {
  // TODO: 수정 예정
  static const String baseUrl =
      'http://musiq-api.ap-northeast-2.elasticbeanstalk.com/';
  static const String searchSong = 'search?search_text=';

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

  /// 검색 결과 곡들 받기.
  /// 200: 검색된 곡들 리스트로 바로 옴.
  /// 400: 에러
  static Future<List<SearchMusicModel>> getSearchMusics(
      String searchText) async {
    List<SearchMusicModel> searchMusicInstances = [];
    final url = Uri.parse("$baseUrl$searchSong$searchText");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> searchMusics = jsonDecode(response.body);
      for (var searchMusic in searchMusics) {
        searchMusicInstances.add(SearchMusicModel.fromJson(searchMusic));
      }
      return searchMusicInstances;
    }
    throw Error();
  }
}
