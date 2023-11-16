import 'package:flutter/material.dart';
import 'package:musiq_front/models/answer_dates_model.dart';
import 'package:musiq_front/models/color_count_model.dart';

import 'answered_music_model.dart';

class AnswerListModel {
  final List<ColorCountModel> colorCounts;
  final List<AnswerDatesModel> answerDates;

  AnswerListModel({required this.colorCounts, required this.answerDates});

  factory AnswerListModel.fromJson(Map<String, dynamic> json) {
    var colorList = json['color_counts'] as List;
    List<ColorCountModel> colors =
        colorList.map((e) => ColorCountModel.fromJson(e)).toList();

    var answerList = json['answer_dates'] as List;
    List<AnswerDatesModel> answerDates =
        answerList.map((e) => AnswerDatesModel.fromJson(e)).toList();

    return AnswerListModel(colorCounts: colors, answerDates: answerDates);
  }
}
