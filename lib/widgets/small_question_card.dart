import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';

class SmallQuestionCard extends StatelessWidget {
  const SmallQuestionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(children: [
        const SizedBox(
          height: 25,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: AppColor.color1),
          height: 120,
          width: 170,
          child: const Row(
            children: [
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "죽기 전에 마지막으로",
                    style: TextStyle(fontSize: 13, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "듣고 싶은 곡은 무엇인가요?",
                    style: TextStyle(fontSize: 13, color: Colors.white),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ],
          ),
        ),
      ]),
      Positioned(
        top: 5,
        left: 10,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: AppColor.color1),
          height: 50,
          width: 50,
        ),
      ),
      Positioned(
          top: 7.5,
          left: 12.5,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.white),
            height: 45,
            width: 45,
            child: const Center(
              child: Text(
                "👋",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ))
    ]);
  }
}
