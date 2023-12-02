// Tab2: 대답했어요 페이지

// TODO: 답변한 질문들 리스트 받아서 띄우기 && 답변곡들 페이지로 연결

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musiq_front/main.dart';
import 'package:musiq_front/models/question_model.dart';
import 'package:musiq_front/screens/question_screen.dart';
import 'package:musiq_front/services/api_service.dart';
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

  Future<List<QuestionModel>> questions = ApiService.getQuestionsListQuestions(MUSIQ.masterUserId);

  updateQuestions() {
    setState(() {
      questions = ApiService.getQuestionsListQuestions(MUSIQ.masterUserId);
    });
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
                        onPressed: () {},
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
