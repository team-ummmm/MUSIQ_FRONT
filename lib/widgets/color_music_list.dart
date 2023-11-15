import 'package:flutter/material.dart';
import 'package:musiq_front/models/daily_music_model.dart';
import 'package:musiq_front/services/api_service.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/color_music_card.dart';
import 'package:musiq_front/models/music_model.dart';

class ColorMusicList extends StatelessWidget {
  final List<DailyMusicModel> musicList;

  const ColorMusicList({required this.musicList, super.key});

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

  Padding colorMusics(int idx) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Container(
        height: _calHeight(musicList[idx].musics.length),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.colorList[musicList[idx].color].withOpacity(0.6),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(20.0),
          itemCount: musicList[idx].musics.length,
          itemBuilder: (BuildContext context, int index) {
            return musicList[idx].musics[index].toCard();
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
        children: List.generate(musicList.length, (index) => colorMusics(index))
            .toList());
  }
}
