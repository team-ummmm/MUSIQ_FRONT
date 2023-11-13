/// Tab 1: 오늘 , 대답할게요
/// 기능: 매일 한 가지 질문에 답을 해야 함.
///      상시 질문 가능하고, 상시 변경되는 다른 질문도 뜸.
///

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musiq_front/screens/search_screen.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/main_question_card.dart';
import 'package:musiq_front/widgets/small_question_card.dart';

class AnswerPage extends StatelessWidget {
  const AnswerPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            child: const MainQuestionCard(
              emoji: '💍',
              question: '결혼식에서 틀고 싶은 노래가 뭐예요?',
              color: AppColor.defaultColor,
              isMain: true,
              isSearching: false,
            )),
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
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 30.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  },
                  child: const MainQuestionCard(
                    emoji: '🍂',
                    question: '죽기 전에 마지막으로 듣고 싶은 곡은 무엇인가요?',
                    color: AppColor.defaultColor,
                    isMain: false,
                    isSearching: false,
                  )),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 170),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  },
                  child: const MainQuestionCard(
                    emoji: '🍂',
                    question: '죽기 전에 마지막으로 듣고 싶은 곡은 무엇인가요?',
                    color: AppColor.defaultColor,
                    isMain: false,
                    isSearching: false,
                  )),
            ),
          ),
        ]),
      ],
    );
  }
}
