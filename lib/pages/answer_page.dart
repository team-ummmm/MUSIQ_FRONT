/// Tab 1: 대답할게요

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musiq_front/main.dart';
import 'package:musiq_front/models/question_model.dart';
import 'package:musiq_front/screens/search_screen.dart';
import 'package:musiq_front/services/api_service.dart';
import 'package:musiq_front/style.dart';

import 'package:musiq_front/widgets/main_question_card.dart';

class AnswerPage extends StatefulWidget {
  const AnswerPage({super.key});

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  int mainId = -1, answeredId1 = -1, answeredId2 = -1;

  late Future<QuestionModel> mainQuestion;
  late Future<QuestionModel> answeredQuestion1;
  late Future<QuestionModel> answeredQuestion2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainQuestion = ApiService.getQuestionsMain(mainId, false);
    answeredQuestion1 = ApiService.getQuestionsAnswered(answeredId1, answeredId2, false);
    answeredQuestion2 = ApiService.getQuestionsAnswered(answeredId2, answeredId1, false);
  }

  void updateMainQuestion() {
    setState(() {
      mainQuestion = ApiService.getQuestionsMain(mainId, true);
    });
  }

  void updateAnsweredQuestion1() {
    setState(() {
      answeredQuestion1 = ApiService.getQuestionsAnswered(answeredId1, answeredId2, true);
    });
  }

  void updateAnsweredQuestion2() {
    setState(() {
      answeredQuestion2 = ApiService.getQuestionsAnswered(answeredId2, answeredId1, true);
    });
  }

  void onQuestionChanged(List<Future<QuestionModel>> nextQuestions) {
    setState(() {
      mainQuestion = nextQuestions[0];
      answeredQuestion1 = nextQuestions[1];
      answeredQuestion2 = nextQuestions[2];
    });
  }

  void showAnswerPageTooltip() {
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
                    '대답할게요!',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'AppleSDGothicNeo',
                      color: AppColor.colorList[8],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    '💡 화면의 질문 카드를 눌러 음악으로 대답해주세요! 천천히 고민해도 돼요:)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "💡 저희 MUSIQ는 맞춤형 질문을 제공해요! 답변하면 같이 맞추어 갈게요:)",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "💡 질문을 바꾸고 싶으면 '새로고침' 버튼을 살짝 눌러서 알려주세요!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 35),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColor.colorList[8])),
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
      future: Future.wait([mainQuestion, answeredQuestion1, answeredQuestion2]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          var mainQuestion = snapshot.data![0];
          var answeredQuestion1 = snapshot.data![1];
          var answeredQuestion2 = snapshot.data![2];
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mainId != mainQuestion.question_id || answeredId1 != answeredQuestion1.question_id || answeredId2 != answeredQuestion2.question_id) {
              setState(() {
                mainId = mainQuestion.question_id;
                answeredId1 = answeredQuestion1.question_id;
                answeredId2 = answeredQuestion2.question_id;
              });
            }
          });

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
                          "대답할게요!",
                          style: TextStyle(
                            fontFamily: 'AppleSDGothicNeo',
                            fontWeight: FontWeight.w500,
                            fontSize: 35,
                          ),
                        ),
                        Text(
                          '천천히 대답해볼까요?',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 18,
                            fontFamily: 'AppleSDGothicNeo',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                    child: IconButton(
                      onPressed: () {
                        showAnswerPageTooltip();
                      },
                      icon: Icon(CupertinoIcons.question_circle, color: Colors.grey.shade700),
                    ),
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
                            mainId: mainId,
                            answeredId1: answeredId1,
                            answeredId2: answeredId2,
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
                        '지금 생각은 어때요?',
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 18, fontFamily: 'AppleSDGothicNeo', fontWeight: FontWeight.w100),
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
                                        question_id: answeredQuestion1.question_id,
                                        question: answeredQuestion1.question_message,
                                        initialColor: answeredQuestion1.main_color,
                                        emoji: answeredQuestion1.emoji,
                                        isMain: true,
                                        isSearching: false,
                                        onQuestionChanged: onQuestionChanged,
                                        mainId: mainId,
                                        answeredId1: answeredId1,
                                        answeredId2: answeredId2,
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
                                  icon: const Icon(CupertinoIcons.refresh_thick),
                                  onPressed: () {
                                    updateAnsweredQuestion1();
                                  },
                                  color: Colors.white,
                                  iconSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                answeredQuestion2.question_id != -1 && answeredQuestion2.question_id != answeredQuestion1.question_id
                    ? Center(
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchScreen(
                                      question_id: answeredQuestion2.question_id,
                                      question: answeredQuestion2.question_message,
                                      initialColor: answeredQuestion2.main_color,
                                      emoji: answeredQuestion2.emoji,
                                      isMain: true,
                                      isSearching: false,
                                      onQuestionChanged: onQuestionChanged,
                                      mainId: mainId,
                                      answeredId1: answeredId1,
                                      answeredId2: answeredId2,
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
                                color: Colors.white,
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
