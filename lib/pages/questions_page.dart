// Tab2: 대답했어요 페이지

// TODO: 답변한 질문들 리스트 받아서 띄우기 && 답변곡들 페이지로 연결

import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/small_question_card.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({super.key});

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
              "대답했어요",
              style: TextStyle(
                fontFamily: 'AppleSDGothicNeo',
                fontWeight: FontWeight.w500,
                fontSize: 35,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: const EdgeInsets.all(11.0),
            children: List.generate(
              10,
              (index) => const Center(
                child: SmallQuestionCard(
                  emoji: '🍂',
                  question: '죽기 전에 마지막으로 듣고 싶은 곡은 무엇인가요?',
                  color: AppColor.defaultColor,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
