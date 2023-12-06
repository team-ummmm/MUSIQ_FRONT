import 'package:flutter/material.dart';
import 'package:musiq_front/models/answer_model.dart';
import 'package:musiq_front/models/player_model.dart';

class PlayerProvider with ChangeNotifier {
  bool isPlaying = false;
  bool displayPlayerScreen = false;
  List<AnswerModel> answerList = [];
  int currentAnswerId = 0;
  String caption = '';
  late Color color;
  String question = '';
  late PlayerModel music;

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

  void addAnswerList(List<AnswerModel> newAnswerList) {
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

  void updateMusic(PlayerModel newMusic) {
    music = newMusic;
    notifyListeners();
  }

  void updateCaption(String newCaption) {
    caption = newCaption;
    notifyListeners();
  }

  void updateQuestion(String newQuestion) {
    question = newQuestion;
    notifyListeners();
  }

  void updateColor(Color newColor) {
    color = newColor;
    notifyListeners();
  }

  void updatePlayer(int newAnswerId, PlayerModel newMusic) {
    currentAnswerId = newAnswerId;
    music = newMusic;
    notifyListeners();
  }
}
