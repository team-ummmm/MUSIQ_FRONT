/// Tab 1: 대답할게요

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musiq_front/main.dart';
import 'package:musiq_front/models/question_model.dart';
import 'package:musiq_front/screens/search_screen.dart';
import 'package:musiq_front/services/api_service.dart';

import 'package:musiq_front/widgets/main_question_card.dart';

class AnswerPage extends StatefulWidget {
  const AnswerPage({super.key});

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  Future<QuestionModel> mainQuestion =
      ApiService.getQuestionsMain(MUSIQ.masterUserId, false);
  Future<QuestionModel> answeredQuestion1 =
      ApiService.getQuestionsAnswered(MUSIQ.masterUserId, false);
  Future<QuestionModel> answeredQuestion2 =
      ApiService.getQuestionsAnswered(MUSIQ.masterUserId, false);

  void updateMainQuestion() {
    setState(() {
      mainQuestion = ApiService.getQuestionsMain(MUSIQ.masterUserId, true);
    });
  }

  void updateAnsweredQuestion1() {
    setState(() {
      answeredQuestion1 =
          ApiService.getQuestionsAnswered(MUSIQ.masterUserId, true);
    });
  }

  void updateAnsweredQuestion2() {
    setState(() {
      answeredQuestion2 =
          ApiService.getQuestionsAnswered(MUSIQ.masterUserId, true);
    });
  }

  void onQuestionChanged(List<Future<QuestionModel>> nextQuestions) {
    setState(() {
      mainQuestion = nextQuestions[0];
      answeredQuestion1 = nextQuestions[1];
      answeredQuestion2 = nextQuestions[2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([mainQuestion, answeredQuestion1, answeredQuestion2]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          var mainQuestion = snapshot.data![0];
          var answeredQuestion1 = snapshot.data![1];
          var answeredQuestion2 = snapshot.data![2];

          return Column(
            children: [
              const Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "대답할게요",
                    style: TextStyle(
                      fontFamily: 'AppleSDGothicNeo',
                      fontWeight: FontWeight.w500,
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    '천천히 고민해봐요!',
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 18,
                        fontFamily: 'AppleSDGothicNeo',
                        fontWeight: FontWeight.w100),
                  ),
                ],
              ),
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(
                            question_id: mainQuestion.question_id,
                            question: mainQuestion.question_message,
                            initialColor: mainQuestion.main_color,
                            emoji: mainQuestion.emoji,
                            isMain: true,
                            isSearching: false,
                            onQuestionChanged: onQuestionChanged,
                          ),
                        ),
                      );
                    },
                    child: MainQuestionCard(
                      question_id: mainQuestion.question_id,
                      question: mainQuestion.question_message,
                      emoji: mainQuestion.emoji,
                      color: mainQuestion.main_color,
                      isMain: true,
                      isSearching: false,
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 300,
                    child: IconButton(
                      icon: const Icon(CupertinoIcons.refresh_thick),
                      onPressed: () {
                        updateMainQuestion();
                      },
                      color: Colors.black,
                      iconSize: 16,
                    ),
                  ),
                ],
              ),
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 30),
                      Text(
                        '이 질문들은 어때요?',
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 18,
                            fontFamily: 'AppleSDGothicNeo',
                            fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                ),
                answeredQuestion1.question_id != -1
                    ? Center(
                        child: Container(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchScreen(
                                        question_id:
                                            answeredQuestion1.question_id,
                                        question:
                                            answeredQuestion1.question_message,
                                        initialColor:
                                            answeredQuestion1.main_color,
                                        emoji: answeredQuestion1.emoji,
                                        isMain: true,
                                        isSearching: false,
                                        onQuestionChanged: onQuestionChanged,
                                      ),
                                    ),
                                  );
                                },
                                child: MainQuestionCard(
                                  question_id: answeredQuestion1.question_id,
                                  question: answeredQuestion1.question_message,
                                  emoji: answeredQuestion1.emoji,
                                  color: answeredQuestion1.main_color,
                                  isMain: false,
                                  isSearching: false,
                                ),
                              ),
                              Positioned(
                                top: 40,
                                left: 300,
                                child: IconButton(
                                  icon:
                                      const Icon(CupertinoIcons.refresh_thick),
                                  onPressed: () {
                                    updateAnsweredQuestion1();
                                  },
                                  color: Colors.black,
                                  iconSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                answeredQuestion2.question_id != -1
                    ? Center(
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchScreen(
                                      question_id:
                                          answeredQuestion2.question_id,
                                      question:
                                          answeredQuestion2.question_message,
                                      initialColor:
                                          answeredQuestion2.main_color,
                                      emoji: answeredQuestion2.emoji,
                                      isMain: true,
                                      isSearching: false,
                                      onQuestionChanged: onQuestionChanged,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(top: 170),
                                child: MainQuestionCard(
                                  question_id: answeredQuestion2.question_id,
                                  question: answeredQuestion2.question_message,
                                  emoji: answeredQuestion2.emoji,
                                  color: answeredQuestion2.main_color,
                                  isMain: false,
                                  isSearching: false,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 210,
                              left: 300,
                              child: IconButton(
                                icon: const Icon(CupertinoIcons.refresh_thick),
                                onPressed: () {
                                  updateAnsweredQuestion2();
                                },
                                color: Colors.black,
                                iconSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ]),
            ],
          );
        }
        return const Center(child: Text('There is something wrong...'));
      },
    );
  }
}
