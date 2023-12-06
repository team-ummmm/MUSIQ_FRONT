// Tab2: 대답했어요 페이지

// TODO: 답변한 질문들 리스트 받아서 띄우기 && 답변곡들 페이지로 연결

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musiq_front/main.dart';
import 'package:musiq_front/models/question_model.dart';
import 'package:musiq_front/screens/question_screen.dart';
import 'package:musiq_front/services/api_service.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/small_question_card.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({required this.key}) : super(key: key);

  @override
  final GlobalKey<QuestionsPageState> key;

  @override
  State<QuestionsPage> createState() => QuestionsPageState();
}

class QuestionsPageState extends State<QuestionsPage> {
  final String userId = '2';

  Future<List<QuestionModel>> questions = ApiService.getQuestionsListQuestions();

  updateQuestions() {
    setState(() {
      questions = ApiService.getQuestionsListQuestions();
    });
  }

  void showQuestionsPageTooltip() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    '대답했어요!',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'AppleSDGothicNeo',
                      color: AppColor.colorList[2],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    '💡 화면의 질문 카드들을 눌러 내 기록을 살펴보아요!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "💡 이전에 했던 답변을 보며 기억을 꺼내보아요. 음악을 틀고 캡션을 확인하며 추억에 잠겨보아요 :)",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "💡 음악을 색으로 나타내었어요. 질문, 음악, 색 함께 돌아보아요!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 35),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColor.colorList[2])),
                        child: const Text(
                          "YES !",
                          style: TextStyle(fontFamily: 'AppleSDGothicNeo', color: Colors.white),
                        )),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: questions,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "대답했어요!",
                            style: TextStyle(
                              fontFamily: 'AppleSDGothicNeo',
                              fontWeight: FontWeight.w500,
                              fontSize: 35,
                            ),
                          ),
                          Text(
                            '내 답변을 돌아보아요',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 18,
                              fontFamily: 'AppleSDGothicNeo',
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                      child: IconButton(
                        onPressed: () {
                          showQuestionsPageTooltip();
                        },
                        icon: Icon(CupertinoIcons.question_circle, color: Colors.grey.shade700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var question = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuestionScreen(
                                question: snapshot.data![index],
                              ),
                            ),
                          );
                        },
                        child: Center(
                          child: SmallQuestionCard(
                            id: question.question_id,
                            emoji: question.emoji,
                            question: question.question_message,
                            color: question.main_color,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
