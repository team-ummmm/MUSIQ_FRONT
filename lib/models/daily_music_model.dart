import 'answered_music_model.dart';

class DailyMusicModel {
  final List<AnsweredMusicModel> musics;
  final int color;

  DailyMusicModel({required this.musics, required this.color});

  factory DailyMusicModel.fromJson(Map<String, dynamic> json) {
    var list = json['musics'] as List;
    List<AnsweredMusicModel> musics =
        list.map((e) => AnsweredMusicModel.fromJson(e)).toList();

    return DailyMusicModel(musics: musics, color: json['color']);
  }
}
