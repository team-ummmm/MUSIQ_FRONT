// 돌아보아요 페이지

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart';
import 'package:musiq_front/main.dart';
import 'package:musiq_front/models/daily_color_model.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/color_music_list.dart';
import 'package:musiq_front/services/api_service.dart';
import 'package:musiq_front/models/daily_music_model.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  DateTime _currentDate = DateTime.now();
  // bool dateChanged = false;
  EventList<Event> _markdeDateMap = EventList<Event>(events: {});
  int consecutive_dates = 0;

  @override
  void initState() {
    super.initState();
  }

  // 캘린더의 연속 답변 일수 및 날짜별 색상 업데이트
  updateCalendar() {
    _fetchConsecutiveDates();
    _fetchDailyColors();
  }

  // icon builder
  static Widget _colorWidget(String day, int color) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.colorList[color],
        borderRadius: BorderRadius.circular(100),
      ),
      // child: Center(
      //   child: Text(
      //     day,
      //     style: const TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 15,
      //     ),
      //   ),
      // ),
    );
  }

  // 선택된 날짜 및 해당 음악들 리턴 함수
  Widget _showDailyMusicList(DateTime selectedDate) {
    Future<List<DailyMusicModel>> dailyMusics = ApiService.getDailyMusics(
        MUSIQ.masterUserId, selectedDate.toString().split(' ')[0]);

    return FutureBuilder(
        future: dailyMusics,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 30),
                      Text(
                        DateFormat('yyy년 MM월 d일')
                            .format(selectedDate)
                            .toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                ColorMusicList(
                  musicList: snapshot.data!,
                ),
              ],
            );
          }
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(child: CircularProgressIndicator()),
          );
        });
  }

  // 스트릭 정보 불러오기
  Future<void> _fetchConsecutiveDates() async {
    var dates = await ApiService.getConsecutiveDates(MUSIQ.masterUserId);
    setState(() {
      consecutive_dates = dates;
    });
  }

  // 날짜별 색상 정보 불러오기 및 그리기
  Future<void> _fetchDailyColors() async {
    var data = await ApiService.getDailyColor(MUSIQ.masterUserId);
    _markdeDateMap.clear();
    for (var dailyColor in data) {
      _markdeDateMap.add(
          DateTime(dailyColor.formattedDate()[0], dailyColor.formattedDate()[1],
              dailyColor.formattedDate()[2]),
          Event(
              date: DateTime(2023, 10, 20),
              title: '',
              icon: (_colorWidget(dailyColor.formattedDate()[2].toString(),
                  dailyColor.color))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
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
                          color: Colors.grey.shade400.withOpacity(0.8)),
                      width: 120,
                      height: 50,
                      child: Center(
                          child: Text(
                        "🎨X$consecutive_dates",
                        style: const TextStyle(fontSize: 25),
                      )),
                    ),
                    const SizedBox(width: 30),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade400.withOpacity(0.8)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 330,
                      height: 400,
                      child: CalendarCarousel<Event>(
                        onDayPressed: (DateTime date, List<Event> events) {
                          setState(() => _currentDate = date);
                          // dateChanged = true;
                        },
                        weekendTextStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        daysTextStyle: const TextStyle(color: Colors.white),
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
                        todayButtonColor: Colors.grey.shade400.withOpacity(0.8),
                        todayTextStyle: const TextStyle(
                            color: Colors.white,
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
                        showIconBehindDayText: true,
                        // daysHaveCircularBorder: true,
                        onCalendarChanged: (DateTime date) {
                          setState(() {
                            _currentDate = date;
                          });
                        },
                        staticSixWeekFormat: true,
                        headerText: DateFormat('yyy년 MM월')
                            .format(_currentDate)
                            .toString(),
                        headerTextStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                        leftButtonIcon: const Icon(CupertinoIcons.left_chevron),
                        rightButtonIcon:
                            const Icon(CupertinoIcons.right_chevron),
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
                            margin:
                                const EdgeInsets.symmetric(horizontal: 16.0),
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
                _showDailyMusicList(_currentDate),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
