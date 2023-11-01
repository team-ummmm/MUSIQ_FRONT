import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/color_music_card.dart';

class ColorMusicList extends StatelessWidget {
  final Color color;
  final String date;
  ColorMusicList({required this.color, required this.date, super.key});

  // 예시 입력
  final List<ColorMusicCard> musicInstances = [
    const ColorMusicCard(
        cover: "austin", title: 'Mouring', artist: 'Post Malone', color: 'red'),
    const ColorMusicCard(
        cover: "austin",
        title: 'Overdive',
        artist: 'Post Malone',
        color: 'red'),
    const ColorMusicCard(
        cover: "austin",
        title: '좋은밤 좋은꿈',
        artist: 'Nerd Connection',
        color: 'red'),
    const ColorMusicCard(
        cover: "austin",
        title: '좋은밤 좋은꿈',
        artist: 'Nerd Connection',
        color: 'red'),
  ];

  // 리스트 높이 계산 함수
  double _calHeight(int cnt) {
    if (cnt == 1) {
      return 90;
    } else if (cnt == 2) {
      return 155;
    } else if (cnt == 3) {
      return 220;
    }
    return 230;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: _calHeight(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color.withOpacity(0.6),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(20.0),
          itemCount: musicInstances.length,
          itemBuilder: (BuildContext context, int index) {
            return musicInstances[index];
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
