class QuestionModel {
  final int id;
  final String title, emoji, color;

  QuestionModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        emoji = json['emoji'],
        color = json['color'];
}
