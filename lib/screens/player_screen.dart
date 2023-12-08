// 답변ID 던지면
// 질문, 캡션유무, 뮤직객체(아티스트, 곡제목, 색깔, 커버URL, 노래URL) 받아옴
// TODO: 키 추가

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musiq_front/di/providers/player_provider.dart';
import 'package:musiq_front/main.dart';
import 'package:musiq_front/pages/root_page.dart';
import 'package:musiq_front/services/api_service.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/caption_dialog.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:musiq_front/models/player_model.dart';
import 'package:musiq_front/widgets/slide_down_route.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late int answerId;
  String question = "";
  late Future<String> caption;
  bool showCaption = false;
  bool isPlaying = false;
  bool hasPlayed = false;
  Duration currentPosition = Duration.zero;
  Duration currentDuration = Duration.zero;
  late Future<PlayerModel> music;
  late AudioPlayer audioPlayer;

  Timer? _timer;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _counter++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _playAudio(String url) async {
    try {
      audioPlayer = context.read<PlayerProvider>().audioPlayer;
      if (!hasPlayed) {
        await audioPlayer.play(UrlSource(url));
      } else {
        await audioPlayer.seek(currentPosition);
        await audioPlayer.resume();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _pauseAudio() async {
    try {
      audioPlayer = context.read<PlayerProvider>().audioPlayer;
      await audioPlayer.pause();
      // context.read<PlayerProvider>().pause();
      currentPosition = await audioPlayer.getCurrentPosition() ?? Duration.zero;
    } catch (e) {
      print(e.toString());
    }
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
    answerId = context.watch<PlayerProvider>().currentAnswerId;
    isPlaying = context.watch<PlayerProvider>().isPlaying;
    currentPosition = context.watch<PlayerProvider>().currentPosition;
    currentDuration = context.watch<PlayerProvider>().currentDuration;
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
                        // TODO
                        onPressed: () {
                          context.read<PlayerProvider>().toggleScreen(false);
                          Navigator.pop(context);
                        },
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
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'AppleSDGothicNeo'),
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
                                      return CaptionDialog(
                                          updateCaption: updateCaption);
                                    });
                              },
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showCaption
                                ? showCaption = false
                                : showCaption = true;
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
                                    child: Opacity(
                                        opacity: showCaption ? 0.5 : 1,
                                        child: SizedBox(
                                          width: 200,
                                          height: 200,
                                          child: Image.network(
                                            snapshot.data!.music.coverUrl,
                                            headers: const {
                                              "User-Agent":
                                                  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
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
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return SizedBox(
                                            width: 300,
                                            child: Center(
                                              child: Text(
                                                snapshot.data!,
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white),
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
                          snapshot.data!.music.artistName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              decoration: TextDecoration.none),
                        ),
                        Text(snapshot.data!.music.musicName,
                            style: const TextStyle(
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
                                audioPlayer
                                    .seek(Duration(seconds: value.toInt()));
                              });
                              // context
                              //     .read<PlayerProvider>()
                              //     .seekDuration(value);
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
                                // TODO: 다음 곡 이전 곡 재생 구현 => question_screen에서 답변 리스트를 만들고 인덱스를 더하고 빼주는 함수를 인자로 player_screen을 생성하면 될 듯
                                onPressed: () {
                                  context.read<PlayerProvider>().playPrev();
                                }),
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
                                    color: AppColor.colorList[
                                        snapshot.data!.music.musicColor],
                                    iconSize: 50,
                                    onPressed: () {
                                      // context.read<PlayerProvider>().pause();
                                      _pauseAudio();
                                    })
                                : IconButton(
                                    icon: const Icon(
                                        CupertinoIcons.play_arrow_solid),
                                    color: AppColor.colorList[
                                        snapshot.data!.music.musicColor],
                                    iconSize: 50,
                                    onPressed: () {
                                      context.read<PlayerProvider>().setUrl(
                                          snapshot.data!.music.musicUrl);
                                      // context.read<PlayerProvider>().play();
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
                            child: IconButton(
                                icon: const Icon(CupertinoIcons.forward_fill),
                                onPressed: () {
                                  context.read<PlayerProvider>().playPrev();
                                }),
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
              return const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }));
  }

  void updateCaption(String newCaption) {
    setState(() {
      ApiService.postCaption(newCaption, answerId);
      caption = ApiService.getCaption(answerId);
    });
  }
}
