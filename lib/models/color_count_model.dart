class ColorCountModel {
  final int color_name, count;

  ColorCountModel.fromJson(Map<String, dynamic> json)
      : color_name = json['color_name'],
        count = json['count'];
}
