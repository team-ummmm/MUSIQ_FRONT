import 'package:flutter/material.dart';
import 'package:musiq_front/main.dart';
import 'package:musiq_front/models/answer_dates_model.dart';
import 'package:musiq_front/models/answered_music_model.dart';
import 'package:musiq_front/screens/player_screen.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/daily_music_card.dart';
import 'package:musiq_front/widgets/slide_down_route.dart';

/// TODO: TempList를 DailyMusicList로 바꾸기
/// DailyMusicList는 ColorMusicList로 바꾸기
///
class DailyMusicList extends StatefulWidget {
  final AnswerDatesModel dailyMusic;
  const DailyMusicList({super.key, required this.dailyMusic});

  @override
  State<DailyMusicList> createState() => _DailyMusicListState();
}

class _DailyMusicListState extends State<DailyMusicList> {
  @override
  Widget build(BuildContext context) {
    var todayColor = AppColor.colorList[widget.dailyMusic.dayColor];
    var month = widget.dailyMusic.answerDate.substring(5, 7);
    var day = widget.dailyMusic.answerDate.substring(8, 10);
    var answers = widget.dailyMusic.answers;

    return Container(
      height: 180,
      color: todayColor.withOpacity(0.3),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
            child: Row(
              children: [
                SizedBox(
                  width: 45,
                  child: Text(
                    '$month월',
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
                SizedBox(
                  width: 35,
                  child: Text(
                    '$day일',
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
              Expanded(
                child: SizedBox(
                  height: 140,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...answers.map((e) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => PlayerScreen(
                                //       answerId: e.answerId,
                                //     ),
                                //   ),
                                // );
                                Navigator.of(context).push(SlideDownRoute(
                                    page: PlayerScreen(
                                  answerId: e.answerId,
                                )));
                              },
                              child: DailyMusicCard(
                                cover: e.music.cover_url,
                                title: e.music.music_name,
                                artist: e.music.artist_name,
                                color: '1',
                              ),
                            ),
                          );
                        }).toList(),
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
