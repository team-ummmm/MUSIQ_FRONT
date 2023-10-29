import 'package:flutter/material.dart';

// TODO: 파라미터로 색깔, 검생창 유무, 질문, 이모지 받기

class MainQuestionCard extends StatelessWidget {
  final String emoji;
  final String question;
  final Color color;
  final bool main;

  const MainQuestionCard({
    required this.emoji,
    required this.question,
    required this.color,
    required this.main,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(children: [
        const SizedBox(
          height: 50,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: color),
          height: main ? 180 : 100,
          width: 340,
          child: Padding(
            padding: EdgeInsets.only(top: main ? 25.0 : 15.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  question,
                  style: TextStyle(
                      fontSize: main ? 28 : 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
        ),
      ]),
      Positioned(
        top: main ? 10 : 20,
        left: 20,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: color),
          height: main ? 100 : 60,
          width: main ? 100 : 60,
        ),
      ),
      Positioned(
          top: main ? 15 : 23,
          left: main ? 25 : 22.7,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.white),
            height: main ? 90 : 55,
            width: main ? 90 : 55,
            child: Center(
              child: Text(
                emoji,
                style: TextStyle(fontSize: main ? 40 : 25),
                textAlign: TextAlign.center,
              ),
            ),
          )),
      // 검색창 필드
      // Positioned(
      //   bottom: 30,
      //   left: 20,
      //   child: Container(
      //     width: 300,
      //     height: 30,
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(10),
      //         color: Colors.white.withOpacity(0.8)),
      //     child: const TextField(
      //       decoration: InputDecoration(
      //         icon: Icon(Icons.search),
      //         hintText: "어떤 곡으로 대답하실 건가요?",
      //       ),
      //       style: TextStyle(fontSize: 15, height: 1.0),
      //     ),
      //   ),
      // )
    ]);
  }
}
