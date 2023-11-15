class DailyColorModel {
  final String date;
  final int color;

  DailyColorModel.fromJson(Map<String, dynamic> json)
      : date = json['selected_date'],
        color = json['day_color'];

  List<int> formattedDate() {
    List<int> formattedDate = [];

    for (String str in date.split('-')) {
      formattedDate.add(int.parse(str));
    }

    return formattedDate;
  }
}
