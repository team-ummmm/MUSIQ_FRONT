import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/music_card.dart';

// 쓸지 말지 고민 중 없어도 될 거 같은 클래스
class SearchResultList extends StatelessWidget {
  SearchResultList({super.key});

  final List<MusicCard> musicInstances = [
    const MusicCard(
        cover: "austin", title: 'Mouring', artist: 'Post Malone', color: 'red'),
    const MusicCard(
        cover: "austin",
        title: 'Overdive',
        artist: 'Post Malone',
        color: 'red'),
    const MusicCard(
        cover: "austin",
        title: '좋은밤 좋은꿈',
        artist: 'Nerd Connection',
        color: 'red')
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Stack(children: [
        Container(
          height: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade300,
          ),
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            itemCount: musicInstances.length,
            itemBuilder: (BuildContext context, int index) {
              return musicInstances[index];
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 12,
          left: 20,
          child: SizedBox(
            height: 20,
            child: Text(
              '검색 결과',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
          ),
        ),
      ]),
    );
  }
}
