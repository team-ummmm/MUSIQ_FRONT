import 'package:flutter/material.dart';

class PlayProvider with ChangeNotifier {
  bool _isInPlayerScreen = false;
  bool _isPlaying = false;

  bool get isInPlayerScreen => _isInPlayerScreen;
  bool get isPlaying => _isPlaying;

  void playMusic() {
    _isPlaying = true;
    notifyListeners();
  }

  void pauseMusic() {
    _isPlaying = false;
    notifyListeners();
  }

  void inPlayerMusicScreen() {
    _isInPlayerScreen = true;
    notifyListeners();
  }

  void outPlayerMusicScreen() {
    _isInPlayerScreen = false;
    notifyListeners();
  }
}
