class MusicModel {
  final int musicColor;
  final String musicId, musicName, artistName, coverUrl, musicUrl;

  MusicModel.fromJson(Map<String, dynamic> json)
      : musicId = json['music_id'],
        musicColor = json['music_color'],
        musicName = json['music_name'],
        artistName = json['artist_name'],
        coverUrl = json['cover_url'],
        musicUrl = json['music_url'] ?? '';
}
