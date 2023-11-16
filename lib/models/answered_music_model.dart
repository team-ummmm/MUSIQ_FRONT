import 'package:musiq_front/widgets/color_music_card.dart';

class AnsweredMusicModel {
  final String music_id, music_name, artist_name, cover_url;

  AnsweredMusicModel.fromJson(Map<String, dynamic> json)
      : music_id = json['music_id'],
        music_name = json['music_name'],
        artist_name = json['artist_name'],
        cover_url = json['cover_url'];

  ColorMusicCard toCard() {
    return ColorMusicCard(
        cover: cover_url, artist: artist_name, title: music_name);
  }
}
