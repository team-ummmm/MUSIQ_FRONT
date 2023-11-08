class SearchMusicModel {
  final String error;
  final List<Data> data;

  SearchMusicModel.fromJson(Map<String, dynamic> json)
      : error = json['error'],
        data = json['data'].map((i) => Data.fromJson(i)).toList();
}

class Data {
  final String music_id, music_name, artist_name, cover_url;

  Data.fromJson(Map<String, dynamic> json)
      : music_id = json['music_id'],
        music_name = json['music_name'],
        artist_name = json['artist_name'],
        cover_url = json['cover_url'];
}
