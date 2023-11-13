// TODO: 질문->생성자, (캡션유무, 캡션, 커버, 아티스트, 제목, 재생 길이, 곡 색상)->state

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/caption_dialog.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayerScreen extends StatefulWidget {
  final String question;
  const PlayerScreen({required this.question, super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  String question = "";
  bool isCaptioned = false;
  String caption = "";
  bool showCaption = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool hasPlayed = false;
  Duration currentPosition = Duration.zero;
  Duration currentDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    question = widget.question;
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.playing) {
        setState(() => isPlaying = true);
      } else {
        setState(() => isPlaying = false);
      }
    });
    audioPlayer.onDurationChanged.listen((duration) {
      setState(() => currentDuration = duration);
    });
    audioPlayer.onPositionChanged.listen((position) {
      setState(() => currentPosition = position);
    });
  }

  void _playAudio() async {
    if (!hasPlayed) {
      await audioPlayer.play(UrlSource(
          'https://p.scdn.co/mp3-preview/98a02e9cf5357e0dc0404547c66b24d479c89ac9?cid=8f5d90cfdb934386993813b06425a958'));
    } else {
      await audioPlayer.seek(currentPosition);
      await audioPlayer.resume();
    }
  }

  void _pauseAudio() async {
    await audioPlayer.pause();
    currentPosition = await audioPlayer.getCurrentPosition() ?? Duration.zero;
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
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
                            opacity: showCaption ? 0.5 : 1,
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
                  // showCaption && isCaptioned
                  //     ? SizedBox(
                  //         width: 300,
                  //         child: Center(
                  //           child: Text(
                  //             caption,
                  //             style: TextStyle(
                  //                 fontSize: 25, color: Colors.grey.shade700),
                  //           ),
                  //         ),
                  //       )
                  //     : Container(),
                  showCaption
                      ? (isCaptioned
                          ? SizedBox(
                              width: 300,
                              child: Center(
                                child: Text(
                                  caption,
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.grey.shade700),
                                ),
                              ),
                            )
                          : SizedBox(
                              width: 300,
                              child: Center(
                                child: Text(
                                  "남기고 싶은 말을 적어주세요!",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.grey.shade700),
                                ),
                              ),
                            ))
                      : Container()
                ],
              ),
            ),
            // TODO: 제목, 가수 변경
            Column(children: [
              Text(
                "BIGBANG",
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                    decoration: TextDecoration.none),
              ),
              const Text("Bad Boy",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none)),
            ]),
            Column(
              children: [
                Slider(
                  value: currentPosition.inSeconds.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      audioPlayer.seek(Duration(seconds: value.toInt()));
                    });
                  },
                  min: 0,
                  max: currentDuration.inSeconds.toDouble(),
                  activeColor: Colors.white,
                  inactiveColor: Colors.white,
                ),
                // TODO: min:sec 형식으로 변환 필요 -> 메소드 만들면 될 듯
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatDuration(currentPosition)),
                      Text(formatDuration(currentDuration))
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
                  child: isPlaying
                      ? IconButton(
                          icon: const Icon(CupertinoIcons.pause_fill),
                          color: AppColor.colorList[3],
                          iconSize: 50,
                          onPressed: () {
                            _pauseAudio();
                          })
                      : IconButton(
                          icon: const Icon(CupertinoIcons.play_arrow_solid),
                          color: AppColor.colorList[3],
                          iconSize: 50,
                          onPressed: () {
                            _playAudio();
                          }),
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
