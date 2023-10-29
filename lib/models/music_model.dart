class MusicModel {
  final int id;
  final String title, artist, cover, color, caption, music;

  MusicModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        artist = json['artist'],
        cover = json['cover'],
        color = json['color'],
        caption = json['caption'],
        music = json['music'];
}
