import 'dart:ffi';

class QuestionModel {
  final int question_id;
  final String question_message, emoji, main_color;

  QuestionModel.fromJson(Map<String, dynamic> json)
      : question_id = json['question_id'],
        question_message = json['question_message'],
        emoji = json['emoji'],
        main_color = json['main_color'];
}
