import 'package:flutter/material.dart';
import 'package:musiq_front/screens/search_screen.dart';
import 'package:musiq_front/style.dart';

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
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.color1),
            height: 240,
            width: 340,
            child: const Row(
              children: [
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "죽기 전에 마지막으로",
                      style: TextStyle(fontSize: 28, color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "듣고 싶은 곡은 무엇인가요?",
                      style: TextStyle(fontSize: 28, color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
      Positioned(
        top: 10,
        left: 20,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: AppColor.color1),
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
      Positioned(
        bottom: 30,
        left: 20,
        child: Container(
          width: 300,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.8)),
          child: const TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.search),
              hintText: "어떤 곡으로 대답하실 건가요?",
            ),
            style: TextStyle(fontSize: 15, height: 1.0),
          ),
        ),
      )
    ]);
  }
}
