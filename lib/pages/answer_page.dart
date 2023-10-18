// '대답할게요' 탭

import 'package:flutter/material.dart';
import 'package:musiq_front/widgets/main_question_card.dart';
import 'package:musiq_front/widgets/small_question_card.dart';

class AnswerPage extends StatelessWidget {
  const AnswerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  "대답할게요",
                  style: TextStyle(
                      fontFamily: 'SF-Pro-Rounded-Black',
                      // fontWeight: FontWeight.w700,
                      fontSize: 40),
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
        ));
  }
}
