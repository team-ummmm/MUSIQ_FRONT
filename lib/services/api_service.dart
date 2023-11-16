import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:musiq_front/models/daily_color_model.dart';
import 'package:musiq_front/models/daily_music_model.dart';
import 'package:musiq_front/models/music_model.dart';
import 'package:musiq_front/models/player_model.dart';
import 'package:musiq_front/models/question_model.dart';
import 'package:musiq_front/models/search_music_model.dart';

// TODO: ERROR 수신한 경우 팝업 혹은 다른 방식으로 알리기
class ApiService {
  static const String baseUrl = 'http://musiq-api.ap-northeast-2.elasticbeanstalk.com';
  static const String search = 'search';
  static const String questionListQuestions = 'question-list/questions';
  static const String questionListAnswers = 'question-list/answers';
  static const String questionMain = 'question/main';
  static const String questionAnswered = 'question/answered';

  static const String calendarData = 'calendar/calendar-data';
  static const String calendarDate = 'calendar/date';

  static const String playSongPlay = 'play-song/play';
  static const String playSongCaption = 'play-song/caption';

  static const String requestUserId = 'user_id=';
  static const String requestRefresh = 'refresh=';
  static const String requestSearchText = 'search_text=';
  static const String requestQuestionId = 'question_id=';
  static const String requestMusicId = 'music_id=';
  static const String requestDate = 'selected_date=';
  static const String requestAnswerId = 'answer_id=';
  static const String requestCaptionText = 'caption_text=';

  /// Tab 1; questionMain 1개. 한 번 호출
  /// 200: 대답 안 한 질문 하나 받기.
  /// 400: 에러
  static Future<QuestionModel> getQuestionsMain(String userId, bool refresh) async {
    QuestionModel question;
    final url = Uri.parse("$baseUrl/$questionMain?$requestUserId$userId&$requestRefresh$refresh");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      question = QuestionModel.fromJson(jsonDecode(response.body));
      print(question);
      return question;
    }
    throw Error();
  }

  /// Tab 1; questionAnswered 1개씩 두 번 호출하기
  /// 200: 대답 한 질문 하나 받기.
  /// 400: 에러
  static Future<QuestionModel> getQuestionsAnswered(String userId, bool refresh) async {
    QuestionModel question;
    final url = Uri.parse("$baseUrl/$questionAnswered?$requestUserId$userId&$requestRefresh$refresh");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      question = QuestionModel.fromJson(jsonDecode(response.body));
      print(question);
      return question;
    }
    throw Error();
  }

  /// Tab 2; 사용자 질문들 리스트 받기. 각 질문의 대답들은 따로 받음.
  /// 200: 대답했던 질문들 리스트로 바로 옴,
  /// 400: 에러
  static Future<List<QuestionModel>> getQuestionsListQuestions(String userId) async {
    List<QuestionModel> questionInstances = [];
    final url = Uri.parse("$baseUrl/$questionListQuestions?$requestUserId$userId");
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

  /// search_screen; 검색 결과 곡들 받기.
  /// 200: 검색된 곡들 리스트로 바로 옴.
  /// 400: 에러
  static Future<List<SearchMusicModel>> getSearchMusics(String searchText) async {
    List<SearchMusicModel> searchMusicInstances = [];
    final url = Uri.parse("$baseUrl/$search?$requestSearchText$searchText");
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

  // Search_Screen; 곡을 추가하면, 질문 대표 색을 받음.
  static Future<int> postSearchMusic(int questionId, String musicId) async {
    final url = Uri.parse("$baseUrl/$search?$requestQuestionId$questionId&$requestMusicId$musicId");
    final response = await http.post(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      int color = responseData['main_color'];
      print(color);
      return color;
    }
    throw Error();
  }

  // Tab3; 달력 페이지
  // 날짜별 대표 색상 불러오기
  static Future<List<DailyColorModel>> getDailyColor(String userId) async {
    List<DailyColorModel> dailyColorInstances = [];
    final url = Uri.parse("$baseUrl/$calendarData?$requestUserId$userId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> dailyColors = data['selected_dates'];
      for (var dailyColor in dailyColors) {
        dailyColorInstances.add(DailyColorModel.fromJson(dailyColor));
      }
      return dailyColorInstances;
    }
    throw Error();
  }

  // 스트릭 정보(consecutive_dates)만 받아오기
  static Future<int> getConsecutiveDates(String userId) async {
    final url = Uri.parse("$baseUrl/$calendarData?$requestUserId$userId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> dailyColors = jsonDecode(response.body);
      int consecutiveDates = dailyColors['consecutive_dates'];
      return consecutiveDates;
    }
    throw Error();
  }

  // 날짜별 답변 음악 받아오기
  static Future<List<DailyMusicModel>> getDailyMusics(String userId, String selectedDate) async {
    List<DailyMusicModel> dailyMusicInstances = [];
    final url = Uri.parse("$baseUrl/$calendarDate?$requestDate$selectedDate&$requestUserId$userId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> dailyMusics = jsonDecode(response.body);
      for (var dailyMusic in dailyMusics) {
        dailyMusicInstances.add(DailyMusicModel.fromJson(dailyMusic));
      }
      return dailyMusicInstances;
    }
    throw Error();
  }

  // player_screen; 캡션 불러오기
  static Future<String> getCaption(int answerId) async {
    final url = Uri.parse("$baseUrl/$playSongCaption?$requestAnswerId$answerId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> captionData = jsonDecode(response.body);
      return captionData['caption_text'] ?? '';
    } else {
      throw Error();
    }
  }

  // player_screen; 캡션 추가하기
  static void postCaption(String captionText, int answerId) async {
    final url = Uri.parse("$baseUrl/$playSongCaption?$requestCaptionText$captionText&$requestAnswerId$answerId");
    final response = await http.post(url);

    if (response.statusCode == 200) {
      print('success!');
      return;
    } else {
      print(url);
      throw Error();
    }
  }

  // player_screen; 곡 정보 불러오기
  static Future<PlayerModel> getMusic(int answerId) async {
    final url = Uri.parse("$baseUrl/$playSongPlay?$requestAnswerId$answerId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      PlayerModel music = PlayerModel.fromJson(data);
      return music;
    }
    throw Error();
  }
}
