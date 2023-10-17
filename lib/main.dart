import 'package:flutter/material.dart';
import 'pages/answer_page.dart';

void main() {
  runApp(const MUSIQ());
}

class MUSIQ extends StatelessWidget {
  const MUSIQ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MUSIQ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AnswerPage(),
    );
  }
}
