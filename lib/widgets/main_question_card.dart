import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:musiq_front/screens/search_screen.dart';
import 'package:musiq_front/style.dart';

// TODO: 파라미터로 색깔, 검생창 유무, 질문, 이모지 받기

class MainQuestionCard extends StatelessWidget {
  const MainQuestionCard({
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
              borderRadius: BorderRadius.circular(10),
              color: AppColor.defaultColor),
          height: 180,
          width: 340,
          child: const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  "죽기 전에 마지막으로 듣고 싶은 곡은 무엇인가요?",
                  style: TextStyle(
                      fontSize: 28,
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
        top: 10,
        left: 20,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColor.defaultColor),
          height: 100,
          width: 100,
        ),
      ),
      Positioned(
          top: 15,
          left: 25,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.white),
            height: 90,
            width: 90,
            child: const Center(
              child: Text(
                "👋",
                style: TextStyle(fontSize: 40),
                textAlign: TextAlign.center,
              ),
            ),
          )),
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
