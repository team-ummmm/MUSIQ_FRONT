import 'dart:async';

import 'package:flutter/material.dart';
import 'package:musiq_front/models/search_music_model.dart';
import 'package:musiq_front/services/api_service.dart';
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
  TextEditingController textEditingController = TextEditingController();
  // String searchText = '';
  Timer? _debounce;
  Future<List<SearchMusicModel>>? searchResults;

  _onSearchChanged(String searchText) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(
        () {
          searchResults = ApiService.getSearchMusics(searchText);
        },
      );
    });
  }

  double _calculateHeight(int count) {
    if (count == 1) {
      return 110;
    } else if (count == 2) {
      return 175;
    } else if (count == 3) {
      return 260;
    }
    return 270;
  }

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(() {
      _onSearchChanged(textEditingController.text);
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(35.0),
          child: AppBar(
            backgroundColor: AppColor.backgroudColor,
          )),
      body: Center(
        child: Column(
          children: [
            // TODO: Hero 추가하기
            const MainQuestionCard(
              emoji: '👋',
              question: '죽기 전에 마지막으로 듣고 싶은 곡은?',
              color: AppColor.defaultColor,
              main: true,
            ),
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
              child: TextField(
                controller: textEditingController,
                onChanged: _onSearchChanged,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                  hintText: "어떤 곡으로 대답하실 건가요?",
                ),
                style: const TextStyle(fontSize: 15, height: 1.0),
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder(
              // 하단의 검색 결과 창
              future: searchResults,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Stack(children: [
                      Container(
                        height: _calculateHeight(snapshot.data!.length),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade300,
                        ),
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            var music = snapshot.data![index];
                            return MusicCard(
                                id: music.music_id,
                                cover: music.cover_url,
                                title: music.music_name,
                                artist: music.artist_name);
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
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
