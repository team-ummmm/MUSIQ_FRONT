// 돌아보아요 페이지

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

import 'package:intl/intl.dart' show DateFormat;

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _currentDate = DateTime(2019, 2, 3);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
                          // fontWeight: FontWeight.w700,
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
                  height: 350,
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
                    weekFormat: false,
                    height: 360.0,
                    todayButtonColor: Colors.black54,
                    // selectedDateTime: _currentDate,
                    // markedDateShowIcon: true,
                    // markedDateIconMaxShown: 1,
                    daysHaveCircularBorder: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
