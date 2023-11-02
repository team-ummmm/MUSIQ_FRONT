import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/color_music_card.dart';

// 날짜만 받아서 여기서 해당 날짜의 음악들 불러와서 띄워주기?

class ColorMusicList extends StatelessWidget {
  final String date;
  ColorMusicList({required this.date, super.key});

  // 예시 입력
  final Map<String, List<ColorMusicCard>> musicInstances = {
    '0': [
      const ColorMusicCard(
        cover: "austin",
        title: 'Mouring',
        artist: 'Post Malone',
      ),
      const ColorMusicCard(
        cover: "austin",
        title: 'Overdrive',
        artist: 'Post Malone',
      ),
      const ColorMusicCard(
        cover: "austin",
        title: '좋은밤 좋은꿈',
        artist: 'Nerd Connection',
      ),
    ],
    '3': [
      const ColorMusicCard(
        cover: "austin",
        title: 'Mouring',
        artist: 'Post Malone',
      ),
    ],
    '7': [
      const ColorMusicCard(
        cover: "austin",
        title: 'Mouring',
        artist: 'Post Malone',
      ),
      const ColorMusicCard(
        cover: "austin",
        title: 'Overdrive',
        artist: 'Post Malone',
      ),
      const ColorMusicCard(
        cover: "austin",
        title: '좋은밤 좋은꿈',
        artist: 'Nerd Connection',
      ),
      const ColorMusicCard(
        cover: "austin",
        title: '좋은밤 좋은꿈',
        artist: 'Nerd Connection',
      ),
    ],
  };

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

  Padding colorMusics(String colorIdx) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Container(
        height: _calHeight(musicInstances[colorIdx]!.length),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.colorList[int.parse(colorIdx)].withOpacity(0.6),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(20.0),
          itemCount: musicInstances[colorIdx]!.length,
          itemBuilder: (BuildContext context, int index) {
            return musicInstances[colorIdx]![index];
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(musicInstances.length,
                (index) => colorMusics(musicInstances.keys.elementAt(index)))
            .toList());
  }
}
