// 돌아보아요 페이지

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
// import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        fontFamily: 'SF-Pro-Rounded-Black',
                        fontWeight: FontWeight.w700,
                        fontSize: 40),
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
                      style: TextStyle(fontSize: 30),
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
                  todayButtonColor: Colors.black54,
                  selectedDateTime: _currentDate,
                  markedDateShowIcon: true,
                  // markedDateIconMaxShown: 1,
                  daysHaveCircularBorder: true,
                  onCalendarChanged: (DateTime date) {
                    setState(() {
                      _currentDate = date;
                    });
                  },
                  staticSixWeekFormat: true,
                  headerText:
                      DateFormat('yyy년 MM월').format(_currentDate).toString(),
                  headerTextStyle:
                      const TextStyle(color: Colors.black, fontSize: 23),
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
                      margin: const EdgeInsets.symmetric(horizontal: 16.6),
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
        ],
      ),
    );
  }
}
