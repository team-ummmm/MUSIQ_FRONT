import 'calendar_music_model.dart';

class DailyMusicModel {
  final List<CalendarMusicModel> musics;
  final int color;

  DailyMusicModel({required this.musics, required this.color});

  factory DailyMusicModel.fromJson(Map<String, dynamic> json) {
    var list = json['musics'] as List;
    List<CalendarMusicModel> musics =
        list.map((e) => CalendarMusicModel.fromJson(e)).toList();

    return DailyMusicModel(musics: musics, color: json['color']);
  }
}
