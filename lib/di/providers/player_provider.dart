import 'package:flutter/material.dart';
import 'package:musiq_front/models/answer_model.dart';
import 'package:musiq_front/models/player_model.dart';

class PlayerProvider with ChangeNotifier {
  bool isPlaying = false;
  bool displayPlayerScreen = false;
  List<int> answerList = [];
  int currentAnswerId = 0;

  void toggleScreen(bool value) {
    displayPlayerScreen = value;
    notifyListeners();
  }

  void play() {
    isPlaying = true;
    notifyListeners();
  }

  void pause() {
    isPlaying = false;
    notifyListeners();
  }

  void addAnswerList(List<int> newAnswerList) {
    newAnswerList.map((e) {
      answerList.add(e);
    });
    notifyListeners();
  }

  void resetAnswerList() {
    answerList.clear();
    notifyListeners();
  }

  void updateCurrentAnswerId(int newAnswerId) {
    currentAnswerId = newAnswerId;
    notifyListeners();
  }
}
