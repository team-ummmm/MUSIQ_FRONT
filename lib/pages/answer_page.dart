/// Tab 1: 오늘 , 대답할게요
/// 기능: 매일 한 가지 질문에 답을 해야 함.
///      상시 질문 가능하고, 상시 변경되는 다른 질문도 뜸.
///

import 'package:flutter/material.dart';
import 'package:musiq_front/widgets/main_question_card.dart';
import 'package:musiq_front/widgets/small_question_card.dart';

class AnswerPage extends StatelessWidget {
  const AnswerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Text(
              "대답할게요",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 35),
            ),
          ],
        ),
        MainQuestionCard(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SmallQuestionCard(),
            SmallQuestionCard(),
          ],
        ),
      ],
    );
  }
}
