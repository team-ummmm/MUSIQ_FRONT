import 'package:flutter/material.dart';

import 'package:musiq_front/pages/calendar_page.dart';
import 'package:musiq_front/pages/root_page.dart';
import 'package:musiq_front/screens/search_screen.dart';
import 'package:musiq_front/style.dart';

import 'pages/answer_page.dart';
import 'pages/calendar_page.dart';
import 'style.dart';

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
        appBarTheme: const AppBarTheme(color: AppColor.backgroudColor),
        scaffoldBackgroundColor: AppColor.backgroudColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'AppleSDGothicNeo',
        useMaterial3: true,
      ),
      home: const RootPage(),
      routes: {
        '/answer': (context) => const AnswerPage(),
        '/answer/search': (context) => const SearchScreen(),
        '/calendar': (context) => const CalendarPage(),
      },
    );
  }
}
