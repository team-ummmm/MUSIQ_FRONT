/// Tab 1: 대답할게요

import 'package:flutter/material.dart';
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
  Future<List<QuestionModel>> allQuestions = Future.wait([
    ApiService.getQuestionsMain('2', false),
    ApiService.getQuestionsAnswered('2', false),
    ApiService.getQuestionsAnswered('2', false),
  ]);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: allQuestions,
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
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 18, fontFamily: 'AppleSDGothicNeo', fontWeight: FontWeight.w100),
                  ),
                ],
              ),
              Hero(
                tag: mainQuestion.question_id,
                child: MainQuestionCard(
                  question_id: mainQuestion.question_id,
                  question: mainQuestion.question_message,
                  emoji: mainQuestion.emoji,
                  color: mainQuestion.main_color,
                  isMain: true,
                  isSearching: false,
                ),
              ),
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 30),
                      Text(
                        '이 질문들은 어때요?',
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 18, fontFamily: 'AppleSDGothicNeo', fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: MainQuestionCard(
                      question_id: answeredQuestion1.question_id,
                      question: answeredQuestion1.question_message,
                      emoji: answeredQuestion1.emoji,
                      color: answeredQuestion1.main_color,
                      isMain: false,
                      isSearching: false,
                    ),
                  ),
                ),
                Center(
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
              ]),
            ],
          );
        }
        return const Center(child: Text('There is something wrong...'));
      },
    );
  }
}
