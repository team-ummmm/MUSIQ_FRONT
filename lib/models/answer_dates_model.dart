import 'package:musiq_front/models/answer_model.dart';
import 'package:musiq_front/models/color_count_model.dart';
import 'answered_music_model.dart';

class AnswerDatesModel {
  final String answerDate;
  final int dayColor;
  final List<AnswerModel> answers;

  AnswerDatesModel(
      {required this.answerDate,
      required this.dayColor,
      required this.answers});

  factory AnswerDatesModel.fromJson(Map<String, dynamic> json) {
    var answerList = json['answers'] as List;
    List<AnswerModel> answers =
        answerList.map((e) => AnswerModel.fromJson(e)).toList();
        
    return AnswerDatesModel(
        answerDate: json['answer_date'],
        dayColor: json['day_color'],
        answers: answers);
  }
}
