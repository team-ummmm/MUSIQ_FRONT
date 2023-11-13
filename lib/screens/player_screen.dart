// TODO: 질문->생성자, (캡션유무, 캡션, 커버, 아티스트, 제목, 재생 길이, 곡 색상)->state

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/caption_dialog.dart';

class PlayerScreen extends StatefulWidget {
  final String question;
  const PlayerScreen({required this.question, super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  double _sliderValue = 0;
  String question = "";
  bool isCaptioned = false;
  String caption = "";
  bool showCaption = false;

  @override
  void initState() {
    question = widget.question;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // TODO: 현재 재생 곡 색상으로 변경
        color: AppColor.colorList[3],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(CupertinoIcons.chevron_down),
              color: Colors.white,
              iconSize: 40,
              // TODO: 화면 pop
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      question,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'AppleSDGothicNeo'),
                    ),
                  ),
                  _captionButton(),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  showCaption ? showCaption = false : showCaption = true;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              // TODO: 커버 이미지로 변경
                              Opacity(
                            opacity: showCaption && isCaptioned ? 0.5 : 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade300,
                                  borderRadius: BorderRadius.circular(15)),
                              width: 200,
                              height: 200,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showCaption && isCaptioned
                      ? Center(
                          child: Text(
                            caption,
                            style: const TextStyle(fontSize: 25),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            // TODO: 제목, 가수 변경
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
                // TODO: min:sec 형식으로 변환 필요 -> 메소드 만들면 될 듯
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
                // TODO: 재생 중일 경우 pause 버튼, 아닐 경우 play 버튼
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

  void updateCaption(String newCaption) {
    setState(() {
      caption = newCaption;
      // TODO: 백으로 변경된 캡션 전달
      isCaptioned = true;
    });
  }

  IconButton _captionButton() {
    if (!isCaptioned) {
      return IconButton(
        icon: const Icon(CupertinoIcons.add_circled),
        color: Colors.grey.shade600,
        onPressed: () {
          showDialog(
              context: context,
              // barrierColor: Colors.grey.withOpacity(0.8),
              builder: (BuildContext context) {
                return CaptionDialog(updateCaption: updateCaption);
              });
        },
      );
    } else {
      return IconButton(
        icon: const Icon(CupertinoIcons.check_mark_circled),
        color: Colors.grey.shade600,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CaptionDialog(updateCaption: updateCaption);
              });
        },
      );
    }
  }
}
