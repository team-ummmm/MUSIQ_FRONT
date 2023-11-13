import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:musiq_front/pages/root_page.dart';
import 'package:musiq_front/style.dart';

import 'package:musiq_front/pages/answer_page.dart';
import 'package:musiq_front/screens/search_screen.dart';
import 'package:musiq_front/pages/questions_page.dart';
import 'package:musiq_front/screens/question_screen.dart';
import 'package:musiq_front/pages/calendar_page.dart';

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
        // fontFamily: 'AppleSDGothicNeo',
        useMaterial3: true,
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
      ),
      // TODO: 링크 타고 온 경우 라우트 추가
      home: const RootPage(),
      // home: const PlayerScreen(),
      routes: {
        '/answer': (context) => const AnswerPage(),
        '/answer/search': (context) => const SearchScreen(),
        // '/questions': (context) => QuestionsPage(),
        '/calendar': (context) => const CalendarPage(),
      },
    );
  }
}
