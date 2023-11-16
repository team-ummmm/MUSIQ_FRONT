import 'music_model.dart';

class PlayerModel {
  final String questionMessage;
  final MusicModel music;

  PlayerModel({required this.questionMessage, required this.music});

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    var music = MusicModel.fromJson(json['music']);
    return PlayerModel(questionMessage: json['question_message'], music: music);
  }
}
