import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';

class SmallQuestionCard extends StatelessWidget {
  final int id;
  final String emoji;
  final String question;
  final String color;

  const SmallQuestionCard({
    super.key,
    required this.id,
    required this.emoji,
    required this.question,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(children: [
        const SizedBox(
          height: 25,
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColor.defaultColor),
          height: 120,
          width: 170,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      question,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                  ),
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
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColor.defaultColor),
          height: 50,
          width: 50,
        ),
      ),
      Positioned(
          top: 7.5,
          left: 12.5,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
            height: 45,
            width: 45,
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          )),
    ]);
  }
}
