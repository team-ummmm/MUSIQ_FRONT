import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:musiq_front/pages/answer_page.dart';
import 'package:musiq_front/pages/calendar_page.dart';
import 'package:musiq_front/pages/questions_page.dart';
import 'package:musiq_front/screens/player_screen.dart';
import 'package:musiq_front/style.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _MyRootPageState();
}

class _MyRootPageState extends State<RootPage> {
  int _selectedIndex = 0;

  /// bottom navigation tab 하나당 고유 키 필요
  late final GlobalKey<QuestionsPageState> questionsPageKey = GlobalKey();
  List<Widget>? _pages;

  final List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.bubble_left_bubble_right_fill), label: 'Tab 1'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_fill), label: 'Tab 2'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.calendar), label: 'Tab 3'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: 'Tab 4'),
  ];

  final List<GlobalKey<NavigatorState>> _navigatorKeyList = List.generate(4, (index) => GlobalKey<NavigatorState>());
  @override
  void initState() {
    super.initState();
    // Initialize _pages here
    _pages = [
      const AnswerPage(),
      QuestionsPage(key: questionsPageKey),
      const CalendarPage(),
      const PlayerScreen(
        question: 'hi',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !(await _navigatorKeyList[_selectedIndex].currentState!.maybePop());
      },
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(40.0),
              child: AppBar(
                backgroundColor: AppColor.backgroudColor,
              )),
          body: _pages != null
              ? IndexedStack(
                  index: _selectedIndex,
                  children: _pages!.map((page) {
                    int index = _pages!.indexOf(page);
                    return Navigator(
                      key: _navigatorKeyList[index],
                      onGenerateRoute: (_) {
                        return MaterialPageRoute(builder: (context) => page);
                      },
                    );
                  }).toList(),
                )
              : const Center(child: CircularProgressIndicator()),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.grey.shade300,
            selectedItemColor: AppColor.color1,
            unselectedItemColor: Colors.blueGrey.shade400,
            currentIndex: _selectedIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index) {
              setState(() {
                if (index == 1) {
                  print('hello');
                  questionsPageKey.currentState?.updateQuestions();
                }
                _selectedIndex = index;
              });
            },
            items: bottomItems,
          ),
        ),
      ),
    );
  }
}
