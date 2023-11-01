// TODO: 질문, (캡션유무, 캡션, 커버, 아티스트, 제목, 재생 길이, 곡 색상)

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  double _sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColor.colorList[3],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(CupertinoIcons.chevron_down),
              color: Colors.white,
              iconSize: 40,
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Text(
                      "여행하면서 가장 기억에 남는 곡이 뭐예요?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'AppleSDGothicNeo'),
                    ),
                  ),
                  // 캡션 없을 시 추가 버튼, 있을 시 안 띄우기 or 체크 버튼
                  IconButton(
                    icon: const Icon(CupertinoIcons.add_circled),
                    color: Colors.grey.shade600,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.shade300,
                        borderRadius: BorderRadius.circular(15)),
                    width: 200,
                    height: 200,
                  ),
                ),
                Column(children: [
                  Text(
                    "Post Malone",
                    style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                  ),
                  const Text("Overdrive",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none)),
                ]),
              ],
            ),
            Column(
              children: [
                Slider(
                  value: _sliderValue,
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                    });
                  },
                  min: 0,
                  max: 100,
                  activeColor: Colors.white,
                  inactiveColor: Colors.white,
                ),
                //min:sec 형식으로 변환 필요 -> 메소드 만들면 될 듯
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_sliderValue.toString()),
                      const Text('100')
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black.withOpacity(0.1),
                  ),
                  child: IconButton(
                      icon: const Icon(CupertinoIcons.backward_fill),
                      onPressed: () {}),
                ),
                // 재생 중일 경우 pause 버튼, 아닐 경우 play 버튼
                Container(
                  margin: const EdgeInsets.all(8.0),
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: IconButton(
                      icon: const Icon(CupertinoIcons.play_arrow_solid),
                      color: AppColor.colorList[3],
                      iconSize: 50,
                      onPressed: () {}),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black.withOpacity(0.1),
                  ),
                  child: IconButton(
                      icon: const Icon(CupertinoIcons.forward_fill),
                      onPressed: () {}),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
