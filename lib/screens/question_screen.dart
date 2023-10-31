/// 질문 카드 클릭했을 때, 답변 음악들 모여있는 스크린.
///
/// 질문타이틀: 대표색으로.
/// 재생 버튼: 고정.
/// 색 비율 받아서.
/// 일별로 대표색 띄움.
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/music_card_vertical.dart';

class QuestionScreen extends StatelessWidget {
  final String questionTitle;

  // TODO: 노래들 불러오기
  const QuestionScreen({required this.questionTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(35.0), child: AppBar()),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 80,
                width: 350,
                child: Stack(
                  children: [
                    SizedBox(
                      width: 310,
                      child: Text(
                        questionTitle,
                        style: const TextStyle(
                          fontSize: 30,
                          fontFamily: 'AppleSDGothicNeo',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 285,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            minimumSize: const Size(10, 10)),
                        onPressed: () {},
                        child: Icon(
                          CupertinoIcons.play_circle,
                          color: Colors.grey.shade900,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 15,
                width: 300,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        color: AppColor.color1,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        color: AppColor.color2,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: AppColor.color3,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: AppColor.color4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                //TODO: Future Builder로 리빌딩
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
                    child: Text(
                      '2023',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'SF-Pro-Rounded',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TempList(todayColor: AppColor.colorList[0]),
                  TempList(todayColor: AppColor.colorList[3]),
                  TempList(todayColor: AppColor.colorList[2]),
                  const SizedBox(height: 40),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
                    child: Text(
                      '2022',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'SF-Pro-Rounded',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TempList(todayColor: AppColor.colorList[0]),
                  TempList(todayColor: AppColor.colorList[3]),
                  TempList(todayColor: AppColor.colorList[2]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
