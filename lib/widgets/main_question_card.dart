import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musiq_front/screens/search_screen.dart';
import 'package:musiq_front/style.dart';

class MainQuestionCard extends StatefulWidget {
  final int question_id; // Question_id
  final String emoji;
  final String question;
  final int color;
  final bool isMain;
  final bool isSearching;

  const MainQuestionCard({
    required this.question_id,
    required this.emoji,
    required this.question,
    required this.color,
    required this.isMain,
    required this.isSearching,
    super.key,
  });

  @override
  State<MainQuestionCard> createState() => _MainQuestionCardState();
}

class _MainQuestionCardState extends State<MainQuestionCard> {
  String emoji = '';
  String question = '';
  int color = 0;

  late bool isMain;
  late bool isSearching;

  @override
  void initState() {
    super.initState();
    emoji = widget.emoji;
    question = widget.question;
    color = widget.color;
    isMain = widget.isMain;
    isSearching = widget.isSearching;
  }

  // TODO: 새로고침 동작 구현
  void refreshCard() {
    setState(() {
      emoji = 'hi';
      question = 'testing';
      // color = AppColor.colorList[3];
      isMain = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isSearching) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchScreen(
                question_id: widget.question_id,
                question: widget.question,
                initialColor: widget.color,
                emoji: widget.emoji,
                isMain: true,
                isSearching: true,
              ),
            ),
          );
        }
      },
      child: Stack(
        children: [
          Column(children: [
            SizedBox(
              height: isMain ? 50 : 48,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.colorList[color]),
              height: isMain ? 180 : 100,
              width: 340,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      question,
                      style: TextStyle(
                          fontSize: isMain ? 28 : 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
          ]),
          Positioned(
            top: isMain ? 10 : 20,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColor.colorList[color]),
              height: isMain ? 100 : 60,
              width: isMain ? 100 : 60,
            ),
          ),
          Positioned(
              top: isMain ? 15 : 23,
              left: isMain ? 25 : 22.7,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white),
                height: isMain ? 90 : 55,
                width: isMain ? 90 : 55,
                child: Center(
                  child: Text(
                    emoji,
                    style: TextStyle(fontSize: isMain ? 40 : 25),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
          isSearching
              ? Positioned(top: 40, left: 298, child: Container())
              : Positioned(
                  top: isMain ? 43 : 40,
                  left: 298,
                  child: IconButton(
                    icon: const Icon(CupertinoIcons.refresh_thick),
                    onPressed: () {
                      refreshCard();
                    },
                    color: Colors.black,
                    iconSize: 16,
                  ),
                )
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
        ],
      ),
    );
  }
}
