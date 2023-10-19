// 돌아보아요 페이지

// TODO: 선택된 날짜(_currentDate)에 추가된 곡 정보를 색상 별로 띄우기
// valueNotifier 사용해도 OK

// TODO: 날짜별 색상 이벤트 추가
// initState() 안에 각 날짜별 색상 이벤트 추가하는 함수?
// 날짜와 해당일의 색상이 담긴 Map 있으면 편할 듯

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart';
import 'package:musiq_front/style.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _currentDate = DateTime.now();
  bool dateChanged = false;
  EventList<Event> _markdeDateMap = EventList<Event>(events: {});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // example events(manually added)
    _markdeDateMap.add(
        DateTime(2023, 10, 20),
        Event(
            date: DateTime(2023, 10, 20),
            title: 'Testing',
            icon: (_colorWidget('20', 1))));
    _markdeDateMap.add(
        DateTime(2023, 10, 27),
        Event(
            date: DateTime(2023, 10, 27),
            title: 'Testing2',
            icon: (_colorWidget('27', 2))));
    _markdeDateMap.add(
        DateTime(2023, 10, 21),
        Event(
            date: DateTime(2023, 10, 21),
            title: 'Testing2',
            icon: (_colorWidget('21', 3))));

    return SingleChildScrollView(
      child: Column(
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
                        fontFamily: 'AppleSDGothicNeo',
                        fontWeight: FontWeight.w500,
                        fontSize: 35),
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
                      style: TextStyle(fontSize: 25),
                    )),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 330,
                height: 400,
                child: CalendarCarousel<Event>(
                  onDayPressed: (DateTime date, List<Event> events) {
                    setState(() => _currentDate = date);
                    dateChanged = true;
                  },
                  weekendTextStyle: const TextStyle(
                    color: Colors.red,
                  ),
                  thisMonthDayBorderColor: Colors.grey,
                  customDayBuilder: (
                    /// you can provide your own build function to make custom day containers
                    bool isSelectable,
                    int index,
                    bool isSelectedDay,
                    bool isToday,
                    bool isPrevMonthDay,
                    TextStyle textStyle,
                    bool isNextMonthDay,
                    bool isThisMonthDay,
                    DateTime day,
                  ) {
                    return null;
                  },
                  showWeekDays: true,
                  showHeader: true,
                  weekFormat: false,
                  height: 400.0,
                  todayButtonColor: Colors.grey.shade300,
                  todayTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  selectedDateTime: _currentDate,
                  selectedDayButtonColor: Colors.grey.shade500,
                  selectedDayTextStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  // selectedDayBorderColor: Colors.red,
                  // markedDateCustomTextStyle: const TextStyle(
                  //     color: Colors.white, fontWeight: FontWeight.bold),
                  markedDatesMap: _markdeDateMap,
                  markedDateShowIcon: true,
                  markedDateIconMaxShown: 1,
                  markedDateIconBuilder: (event) {
                    return event.icon;
                  },
                  // showIconBehindDayText: true,
                  // daysHaveCircularBorder: true,
                  onCalendarChanged: (DateTime date) {
                    setState(() {
                      _currentDate = date;
                    });
                  },
                  staticSixWeekFormat: true,
                  headerText:
                      DateFormat('yyy년 MM월').format(_currentDate).toString(),
                  headerTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                  leftButtonIcon: const Icon(CupertinoIcons.left_chevron),
                  rightButtonIcon: const Icon(CupertinoIcons.right_chevron),
                  customWeekDayBuilder: (weekday, weekdayName) {
                    final koreanDaysOfWeek = [
                      '일',
                      '월',
                      '화',
                      '수',
                      '목',
                      '금',
                      '토'
                    ];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        koreanDaysOfWeek[weekday],
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          dateChanged ? Text(_currentDate.toString()) : Container()
        ],
      ),
    );
  }

// icon builder
  static Widget _colorWidget(String day, int color) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.colorList[color],
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Text(
          day,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
