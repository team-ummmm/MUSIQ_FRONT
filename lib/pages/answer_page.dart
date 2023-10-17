import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:musiq_front/widgets/empty_appBar.dart';

class AnswerPage extends StatelessWidget {
  const AnswerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const EmptyAppBar(),
        // appBar: AppBar(
        //   flexibleSpace: const Column(children: [
        //     SizedBox(height: 50),
        //     Row(
        //       children: [
        //         Text(
        //           "오늘, 대답할게요",
        //           style: TextStyle(fontFamily: "SF-Pro-Rounded", fontSize: 30),
        //         )
        //       ],
        //     )
        //   ]),
        // ),
        body: Column(
          children: [
            const Text("hi"),
            Container(
              color: Colors.blue,
              height: 30,
              child: const SizedBox(height: 20),
            ),
          ],
        ));
  }
}
