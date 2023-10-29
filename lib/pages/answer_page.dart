/// Tab 1: 오늘 , 대답할게요
/// 기능: 매일 한 가지 질문에 답을 해야 함.
///      상시 질문 가능하고, 상시 변경되는 다른 질문도 뜸.
///

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
              main: true,
            )),
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
              emoji: '🍂',
              question: '죽기 전에 마지막으로 듣고 싶은 곡은 무엇인가요?',
              color: AppColor.defaultColor,
              main: false,
            )),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SmallQuestionCard(
                emoji: '🍂',
                question: '죽기 전에 마지막으로 듣고 싶은 곡은 무엇인가요?',
                color: AppColor.defaultColor),
            SmallQuestionCard(
                emoji: '🍂',
                question: '죽기 전에 마지막으로 듣고 싶은 곡은 무엇인가요?',
                color: AppColor.defaultColor),
          ],
        ),
      ],
    );
  }
}
