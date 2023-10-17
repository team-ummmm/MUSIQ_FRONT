import 'package:flutter/material.dart';

import '../style.dart';

class MyRootPage extends StatefulWidget {
  const MyRootPage({super.key});

  @override
  State<MyRootPage> createState() => _MyRootPageState();
}

class _MyRootPageState extends State<MyRootPage> {
  int selectedIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.question_answer)),
    const BottomNavigationBarItem(icon: Icon(Icons.person)),
    const BottomNavigationBarItem(icon: Icon(Icons.groups)),
    const BottomNavigationBarItem(icon: Icon(Icons.calendar_today)),
    const BottomNavigationBarItem(icon: Icon(Icons.settings)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroudColor,
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomItems,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blueGrey.shade100,
        selectedItemColor: AppColor.color1,
        unselectedItemColor: Colors.blueGrey.shade400,
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
