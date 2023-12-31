/// 질문 카드 클릭했을 때, 답변 음악들 모여있는 스크린.
///
/// 질문타이틀: 대표색으로.
/// 재생 버튼: 고정.
/// 색 비율 받아서.
/// 일별로 대표색 띄움.
///
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:musiq_front/models/answer_dates_model.dart';
import 'package:musiq_front/models/answer_list_model.dart';
import 'package:musiq_front/models/answer_model.dart';
import 'package:musiq_front/models/question_model.dart';
import 'package:musiq_front/screens/temp_search_screen.dart';
import 'package:musiq_front/services/api_service.dart';
import 'package:musiq_front/style.dart';
import 'package:provider/provider.dart';
import 'package:musiq_front/di/providers/player_provider.dart';

import 'package:musiq_front/widgets/daily_music_list.dart';

class QuestionScreen extends StatefulWidget {
  final QuestionModel question;
  // TODO: 노래들 불러오기
  const QuestionScreen({required this.question, super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late Future<AnswerListModel> answers = ApiService.getAnswerList(widget.question.question_id.toString());

  // late Future<AnswerListModel> answers = ApiService.getAnswerList('35');
  String getYear(String date) {
    return date.substring(0, 4);
  }

  void _loadAnswers() {
    answers = ApiService.getAnswerList(widget.question.question_id.toString());
  }

  @override
  Widget build(BuildContext context) {
    print(widget.question.question_id);
    return FutureBuilder(
        future: answers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var colorCounts = snapshot.data!.colorCounts;
            var answerDates = snapshot.data!.answerDates;
            Map<String, List<AnswerDatesModel>> years = {};

            for (var e in answerDates) {
              String year = getYear(e.answerDate); // 연도 추출
              if (!years.containsKey(year)) {
                years[year] = []; // 연도가 없다면 새 리스트 생성
              }
              years[year]!.add(e); // 해당 연도의 리스트에 객체 추가
            }

            // answer_dates.map((e) => e.answers).forEach((element) {
            //   context
            //       .read<PlayerProvider>()
            //       .addAnswerList(element.map((e) => e.answerId).toList());
            // });

            // print(context.read<PlayerProvider>().answerList);

            return Scaffold(
              appBar: PreferredSize(preferredSize: const Size.fromHeight(35.0), child: AppBar()),
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
                                widget.question.question_message,
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
                                style: ElevatedButton.styleFrom(shape: const CircleBorder(), minimumSize: const Size(10, 10)),
                                onPressed: () async {
                                  final isChanged = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TempSearchScreen(questionModel: widget.question),
                                    ),
                                  );
                                  if (isChanged != null && isChanged) {
                                    setState(() {
                                      _loadAnswers(); // answers를 새로고침
                                    });
                                  }
                                },
                                child: Icon(
                                  CupertinoIcons.plus_circle,
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
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            ...colorCounts
                                .map((e) => Expanded(
                                      flex: e.count,
                                      child: Container(
                                        color: AppColor.colorList[e.color_name],
                                      ),
                                    ))
                                .toList(),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          ...years.entries.map((entry) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min, // 여기에 추가
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
                                  child: Text(
                                    entry.key, // 연도
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'SF-Pro-Rounded',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                ...entry.value.map((answerDateModel) {
                                  return DailyMusicList(
                                    dailyMusic: answerDateModel,
                                  );
                                }).toList(),
                                const SizedBox(height: 40),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            print("snapshot error!");
          }
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(child: CircularProgressIndicator()),
          );
        });

    // return Scaffold(
    //   appBar: PreferredSize(
    //       preferredSize: const Size.fromHeight(35.0), child: AppBar()),
    //   body: Center(
    //     child: Column(
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.all(15.0),
    //           child: SizedBox(
    //             height: 80,
    //             width: 350,
    //             child: Stack(
    //               children: [
    //                 SizedBox(
    //                   width: 310,
    //                   child: Text(
    //                     questionTitle,
    //                     style: const TextStyle(
    //                       fontSize: 30,
    //                       fontFamily: 'AppleSDGothicNeo',
    //                       fontWeight: FontWeight.w400,
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   top: 20,
    //                   left: 285,
    //                   child: ElevatedButton(
    //                     style: ElevatedButton.styleFrom(
    //                         shape: const CircleBorder(),
    //                         minimumSize: const Size(10, 10)),
    //                     onPressed: () {},
    //                     child: Icon(
    //                       CupertinoIcons.play_circle,
    //                       color: Colors.grey.shade900,
    //                       size: 40,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(15.0),
    //           child: Container(
    //             height: 15,
    //             width: 300,
    //             decoration:
    //                 BoxDecoration(borderRadius: BorderRadius.circular(100)),
    //             clipBehavior: Clip.antiAliasWithSaveLayer,
    //             child: Row(
    //               children: [
    //                 Expanded(
    //                   flex: 4,
    //                   child: Container(
    //                     color: AppColor.color1,
    //                   ),
    //                 ),
    //                 Expanded(
    //                   flex: 4,
    //                   child: Container(
    //                     color: AppColor.color2,
    //                   ),
    //                 ),
    //                 Expanded(
    //                   flex: 3,
    //                   child: Container(
    //                     color: AppColor.color3,
    //                   ),
    //                 ),
    //                 Expanded(
    //                   flex: 1,
    //                   child: Container(
    //                     color: AppColor.color4,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Expanded(
    //           child: ListView(
    //             //TODO: Future Builder로 리빌딩
    //             children: [
    //               const Padding(
    //                 padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
    //                 child: Text(
    //                   '2023',
    //                   style: TextStyle(
    //                     fontSize: 30,
    //                     fontFamily: 'SF-Pro-Rounded',
    //                     fontWeight: FontWeight.w600,
    //                   ),
    //                 ),
    //               ),
    //               DailyMusicList(todayColor: AppColor.colorList[0]),
    //               DailyMusicList(todayColor: AppColor.colorList[3]),
    //               DailyMusicList(todayColor: AppColor.colorList[2]),
    //               const SizedBox(height: 40),
    //               const Padding(
    //                 padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
    //                 child: Text(
    //                   '2022',
    //                   style: TextStyle(
    //                     fontSize: 30,
    //                     fontFamily: 'SF-Pro-Rounded',
    //                     fontWeight: FontWeight.w600,
    //                   ),
    //                 ),
    //               ),
    //               DailyMusicList(todayColor: AppColor.colorList[0]),
    //               DailyMusicList(todayColor: AppColor.colorList[3]),
    //               DailyMusicList(todayColor: AppColor.colorList[2]),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
