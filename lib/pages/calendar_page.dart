// 돌아보아요 페이지

import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "돌아보아요",
                    style: TextStyle(
                        fontFamily: 'SF-Pro-Rounded-Black',
                        // fontWeight: FontWeight.w700,
                        fontSize: 40),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey.shade400),
                    width: 120,
                    height: 50,
                    child: const Center(
                        child: Text(
                      "🎨X7",
                      // TODO: streak_count 변수로 변경
                      style: TextStyle(fontSize: 30),
                    )),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
