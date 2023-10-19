import 'package:flutter/material.dart';
import 'package:musiq_front/widgets/main_question_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30.0), child: AppBar()),
      body: const Center(
        child: Column(
          children: [
            // TODO: Hero 추가하기
            MainQuestionCard(),
          ],
        ),
      ),
    );
  }
}
