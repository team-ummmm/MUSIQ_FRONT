import 'package:musiq_front/widgets/color_music_card.dart';

class TmpModel {
  final String music_id, music_name, artist_name, cover_url, music_color;

  TmpModel.fromJson(Map<String, dynamic> json)
      : music_id = json['music_id'],
        music_name = json['music_name'],
        music_color = json['music_color'],
        artist_name = json['artist_name'],
        cover_url = json['cover_url'];
}
