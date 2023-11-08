class SearchMusicModel {
  final String music_id, music_name, artist_name, cover_url;

  SearchMusicModel.fromJson(Map<String, dynamic> json)
      : music_id = json['music_id'],
        music_name = json['music_name'],
        artist_name = json['artist_name'],
        cover_url = json['cover_url'];
}
