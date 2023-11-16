// 답변ID 던지면
// 질문, 캡션유무, 뮤직객체(아티스트, 곡제목, 색깔, 커버URL, 노래URL) 받아옴

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musiq_front/services/api_service.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/caption_dialog.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:musiq_front/models/player_model.dart';

class PlayerScreen extends StatefulWidget {
  final String question;
  const PlayerScreen({required this.question, super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  int answerId = 2;
  String question = "";
  late Future<String> caption;
  bool showCaption = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool hasPlayed = false;
  Duration currentPosition = Duration.zero;
  Duration currentDuration = Duration.zero;
  late Future<PlayerModel> music;

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

  void _playAudio(String url) async {
    if (!hasPlayed) {
      await audioPlayer.play(UrlSource(url));
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
    caption = ApiService.getCaption(answerId);
    music = ApiService.getMusic(answerId);
    return Material(
        child: FutureBuilder(
            future: music,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.colorList[snapshot.data!.music.musicColor],
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
                                snapshot.data!.questionMessage,
                                style: const TextStyle(color: Colors.white, fontSize: 28, decoration: TextDecoration.none, fontWeight: FontWeight.w500, fontFamily: 'AppleSDGothicNeo'),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(CupertinoIcons.add_circled),
                              color: Colors.grey.shade400,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    // barrierColor: Colors.grey.withOpacity(0.8),
                                    builder: (BuildContext context) {
                                      return CaptionDialog(updateCaption: updateCaption);
                                    });
                              },
                            ),
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
                                            child: SizedBox(
                                              width: 200,
                                              height: 200,
                                              child: Image.network(
                                                snapshot.data!.music.coverUrl,
                                                headers: const {
                                                  "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                                                },
                                              ),
                                            )),
                                  ),
                                ],
                              ),
                            ),
                            showCaption
                                ? FutureBuilder(
                                    future: caption,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data == '') {
                                          return const SizedBox(
                                            width: 300,
                                            child: Center(
                                              child: Text(
                                                '남기고 싶은 말을 적어주세요!',
                                                style: TextStyle(fontSize: 25, color: Colors.white),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return SizedBox(
                                            width: 300,
                                            child: Center(
                                              child: Text(
                                                snapshot.data!,
                                                style: const TextStyle(fontSize: 25, color: Colors.white),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                      return Container();
                                    },
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      Column(children: [
                        Text(
                          snapshot.data!.music.musicName,
                          style: const TextStyle(color: Colors.white, fontSize: 12, decoration: TextDecoration.none),
                        ),
                        Text(snapshot.data!.music.artistName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, decoration: TextDecoration.none)),
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text(formatDuration(currentPosition)), Text(formatDuration(currentDuration))],
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
                                // TODO: 다음 곡 이전 곡 재생 구현 => question_screen에서 답변 리스트를 만들고 인덱스를 더하고 빼주는 함수를 인자로 player_screen을 생성하면 될 듯
                                onPressed: () {}),
                          ),
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
                                    color: AppColor.colorList[snapshot.data!.music.musicColor],
                                    iconSize: 50,
                                    onPressed: () {
                                      _pauseAudio();
                                    })
                                : IconButton(
                                    icon: const Icon(CupertinoIcons.play_arrow_solid),
                                    color: AppColor.colorList[snapshot.data!.music.musicColor],
                                    iconSize: 50,
                                    onPressed: () {
                                      _playAudio(snapshot.data!.music.musicUrl);
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
                            child: IconButton(icon: const Icon(CupertinoIcons.forward_fill), onPressed: () {}),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                print("ERROR!");
              }
              return const Text('xival');
            }));
  }

  void updateCaption(String newCaption) {
    setState(() {
      ApiService.postCaption(newCaption, answerId);
      caption = ApiService.getCaption(answerId);
    });
  }
}
