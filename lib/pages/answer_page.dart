import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:musiq_front/widgets/empty_appBar.dart';
import 'package:musiq_front/style.dart';

class AnswerPage extends StatelessWidget {
  const AnswerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroudColor,
        appBar: AppBar(
          backgroundColor: AppColor.backgroudColor,
        ),
        body: Column(
          children: [
            const Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  "대답할게요",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 34),
                ),
              ],
            ),
            Container(
              color: AppColor.color1,
              height: 30,
              width: 30,
              child: const SizedBox(height: 20),
            ),
          ],
        ));
  }
}
