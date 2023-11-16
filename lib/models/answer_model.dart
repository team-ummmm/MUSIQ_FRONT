import 'answered_music_model.dart';

class AnswerModel {
  final int answerId;
  final String caption;
  final AnsweredMusicModel music;

  AnswerModel(
      {required this.answerId, required this.caption, required this.music});

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    var answer = AnsweredMusicModel.fromJson(json['music']);
    return AnswerModel(
        answerId: json['answer_id'],
        caption: json['caption'] ?? '',
        music: answer);
  }
}
