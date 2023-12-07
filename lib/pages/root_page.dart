import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:musiq_front/pages/answer_page.dart';
import 'package:musiq_front/pages/calendar_page.dart';
import 'package:musiq_front/pages/color_page.dart';
import 'package:musiq_front/pages/questions_page.dart';
import 'package:musiq_front/pages/story_page.dart';
import 'package:musiq_front/screens/player_screen.dart';
import 'package:musiq_front/style.dart';
import 'package:provider/provider.dart';
import 'package:musiq_front/di/providers/player_provider.dart';
import 'package:musiq_front/widgets/slide_down_route.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _MyRootPageState();
}

class _MyRootPageState extends State<RootPage> {
  int _selectedIndex = 0;

  bool showAppBar = true;

  /// bottom navigation tab 하나당 고유 키 필요
  late final GlobalKey<QuestionsPageState> questionsPageKey = GlobalKey();
  late final GlobalKey<CalendarPageState> calendarPageKey = GlobalKey();
  List<Widget>? _pages;

  final List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.bubble_left_bubble_right), label: 'Tab 1'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: 'Tab 2'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.calendar), label: 'Tab 3'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.paintbrush), label: 'Tab 4'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.book), label: 'Tab 5'),
  ];

  final List<GlobalKey<NavigatorState>> _navigatorKeyList =
      List.generate(5, (index) => GlobalKey<NavigatorState>());
  @override
  void initState() {
    super.initState();
    // Initialize _pages here
    _pages = [
      const AnswerPage(),
      QuestionsPage(key: questionsPageKey),
      CalendarPage(key: calendarPageKey),
      const ColorPage(),
      const StoryPage(),
    ];
    final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    playerProvider.addListener(_onPlayerStateChanged);
  }

  @override
  void dispose() {
    super.dispose();
    final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    playerProvider.removeListener(_onPlayerStateChanged);
  }

  void toggleAppBar(bool show) {
    setState(() {
      showAppBar = show;
    });
  }

  void _onPlayerStateChanged() {
    final playerProvider = Provider.of<PlayerProvider>(context, listen: false);

    // displayPlayerScreen 상태가 true일 때 PlayerScreen으로 네비게이트합니다.
    if (playerProvider.displayPlayerScreen) {
      Navigator.of(context).push(SlideDownRoute(page: PlayerScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<PlayerProvider>().setPlayer();
    print('building root page!');
    return WillPopScope(
      onWillPop: () async {
        return !(await _navigatorKeyList[_selectedIndex]
            .currentState!
            .maybePop());
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
            selectedItemColor: AppColor.colorList[8],
            unselectedItemColor: Colors.blueGrey.shade400,
            currentIndex: _selectedIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index) {
              setState(() {
                if (index == 1) {
                  print('hello');
                  questionsPageKey.currentState?.updateQuestions();
                } else if (index == 2) {
                  calendarPageKey.currentState?.updateCalendar();
                }
                _selectedIndex = index;
              });
            },
            items: bottomItems,
          ),
          floatingActionButton: context.watch<PlayerProvider>().isPlaying
              ? IconButton(
                  iconSize: 40,
                  onPressed: () {
                    context.read<PlayerProvider>().toggleScreen(true);
                  },
                  icon: const Icon(CupertinoIcons.play_circle_fill))
              : Container(),
        ),
      ),
    );
  }
}
