import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musiq_front/models/answer_model.dart';
import 'package:musiq_front/models/player_model.dart';
import 'package:musiq_front/screens/player_screen.dart';
import 'package:musiq_front/services/api_service.dart';

class PlayerProvider with ChangeNotifier {
  bool isPlaying = false;
  bool hasPlayed = false;
  String url = '';
  bool displayPlayerScreen = false;
  List<int> answerList = [];
  int currentAnswerId = 0;
  Duration currentPosition = Duration.zero;
  Duration currentDuration = Duration.zero;
  final AudioPlayer audioPlayer = AudioPlayer();
  String caption = '';
  late PlayerModel music;

  void setCaption(String newCaption) {
    caption = newCaption;
    notifyListeners();
  }

  void setMusic(PlayerModel newMusic) {
    music = newMusic;
    notifyListeners();
  }

  void toggleScreen(bool value) {
    displayPlayerScreen = value;
    notifyListeners();
  }

  void setPlayer() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.playing) {
        isPlaying = true;
      } else {
        isPlaying = false;
      }
    });
    audioPlayer.onDurationChanged.listen((duration) {
      currentDuration = duration;
    });
    audioPlayer.onPositionChanged.listen((position) {
      currentPosition = position;
    });
    audioPlayer.onPlayerComplete.listen((event) {
      onCompletion();
    });
    // notifyListeners();
  }

  void onCompletion() {
    playNext();
  }

  void playNext() {
    print(answerList);
    int nextAnswerIdx = answerList.indexOf(currentAnswerId) + 1;
    if (nextAnswerIdx >= answerList.length) nextAnswerIdx = 0;
    updateCurrentAnswerId(answerList[nextAnswerIdx]);
  }

  void playPrev() {
    int nextAnswerIdx = answerList.indexOf(currentAnswerId) - 1;
    if (nextAnswerIdx < 0) nextAnswerIdx = answerList.length - 1;
    updateCurrentAnswerId(answerList[nextAnswerIdx]);
  }

  void play() async {
    isPlaying = true;
    if (!hasPlayed) {
      await audioPlayer.play(UrlSource(url));
    } else {
      await audioPlayer.seek(currentPosition);
      await audioPlayer.resume();
    }
    // notifyListeners();
  }

  void seekDuration(double value) {
    audioPlayer.seek(Duration(seconds: value.toInt()));
    notifyListeners();
  }

  void pause() async {
    isPlaying = false;
    await audioPlayer.pause();
    currentPosition = await audioPlayer.getCurrentPosition() ?? Duration.zero;
    // notifyListeners();
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
    if (newAnswerId == currentAnswerId) {
      return;
    }
    currentPosition = Duration.zero;
    pause();
    currentAnswerId = newAnswerId;
    notifyListeners();
  }

  void setUrl(String newUrl) {
    url = newUrl;
    // notifyListeners();
  }

  // void setCurrentPosition(Duration position) {
  //   currentPosition = position;
  //   notifyListeners();
  // }

  // void setDuration(Duration duration) {
  //   currentDuration = duration;
  //   notifyListeners();
  // }
}
