import 'package:flutter/material.dart';
import 'package:musiq_front/widgets/music_card_vertical.dart';

/// TODO: TempList를 DailyMusicList로 바꾸기
/// DailyMusicList는 ColorMusicList로 바꾸기
///
class TempList extends StatelessWidget {
  final Color todayColor;
  const TempList({super.key, required this.todayColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      color: todayColor.withOpacity(0.3),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 45,
                  child: Text(
                    '10월',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                const SizedBox(width: 3),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: todayColor.withOpacity(0.8)),
                ),
                const SizedBox(width: 7),
                const SizedBox(
                  width: 35,
                  child: Text(
                    '31일',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 63),
              Container(
                height: 140,
                width: 2,
                color: todayColor,
              ),
              const Expanded(
                child: SizedBox(
                  height: 140,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: MusicCardVertical(
                            cover: 'cover',
                            title: '좋은밤 좋은꿈',
                            artist: 'Nerd Connection',
                            color: 'color1',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: MusicCardVertical(
                            cover: 'cover',
                            title: '좋은밤 좋은꿈',
                            artist: 'Nerd Connection',
                            color: 'color1',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: MusicCardVertical(
                            cover: 'cover',
                            title: '좋은밤 좋은꿈',
                            artist: 'Nerd Connection',
                            color: 'color1',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: MusicCardVertical(
                            cover: 'cover',
                            title: '좋은밤 좋은꿈',
                            artist: 'Nerd Connection',
                            color: 'color1',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
