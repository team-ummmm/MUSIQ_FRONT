import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/main_question_card.dart';

class AnswerPage extends StatelessWidget {
  const AnswerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroudColor,
        appBar: AppBar(
          backgroundColor: AppColor.backgroudColor,
        ),
        body: const Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  "대답할게요",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 39),
                ),
              ],
            ),
            MainQuestionCard(),
          ],
        ));
  }
}
