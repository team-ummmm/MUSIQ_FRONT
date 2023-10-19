import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/main_question_card.dart';
import 'package:musiq_front/widgets/music_card.dart';
import 'package:musiq_front/widgets/search_result_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(35.0), child: AppBar()),
      body: Center(
        child: Column(
          children: [
            // TODO: Hero 추가하기
            const MainQuestionCard(),
            const SizedBox(
              height: 20,
            ),
            Container(
              // 중단의 텍스트 필드
              width: 350,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                  hintText: "어떤 곡으로 대답하실 건가요?",
                ),
                style: TextStyle(fontSize: 15, height: 1.0),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              // 하단의 검색 결과 창
              // TODO: 텍스트 필드와 연결
              // TODO: 크기 3으로 고정 시켜두고 안에서 스크롤 돌릴지, 아니면 검색 결과만큼 하단에 스크롤뷰로 뿌려줄지 고민
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
                  left: 20,
                  child: Container(
                    height: 30,
                    width: 320,
                    color: Colors.grey.shade300,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '검색 결과',
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
