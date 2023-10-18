import 'package:flutter/material.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'SF-Pro-Rounded',
        scaffoldBackgroundColor: AppColor.backgroudColor,
        appBarTheme:
            const AppBarTheme(backgroundColor: AppColor.backgroudColor),
        useMaterial3: true,
      ),
      home: const CalendarPage(),
    );
  }
}
