import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:musiq_front/main.dart';
import 'package:musiq_front/models/color_card_model.dart';
import 'package:musiq_front/models/story_card_model.dart';
import 'package:musiq_front/pages/login_page.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/color_card.dart';
import 'package:musiq_front/widgets/cube_painter.dart';
import 'package:musiq_front/widgets/point_cloud_painter.dart';
import 'package:musiq_front/widgets/story_card.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  List<ColorCardModel> colorCards = [
    ColorCardModel(colorNumber: 1, colorName: 'Blue', colorCode: '#3897F0', colorDescription: '신뢰성을 보여주며, 편안한 감정을 전달해요. 하지만, 차가운 컬러이기에 거리감과 슬픈 감정도 함께 제공해요.'),
    ColorCardModel(colorNumber: 2, colorName: 'Purple', colorCode: '#B638F2', colorDescription: '미스테리함과 화려함을 지니고 있어요. 빨강과 파랑의 조화를 이루고 있어 안정을 느낄 수 있지만, 산만해질 수도 있어요.'),
    ColorCardModel(colorNumber: 3, colorName: 'Light Green', colorCode: '#63CB24', colorDescription: '자연, 균형, 조화를 나타내며, 신선함과 만족감을 제공해요. 대체로 긍정적인 경험을 나타내요.'),
    ColorCardModel(colorNumber: 4, colorName: 'Indigo', colorCode: '#7637F4', colorDescription: '신뢰성을 보여주며, 편안한 감정을 전달해요. 하지만, 차가운 컬러이기에 거리감과 슬픈 감정도 함께 제공해요.'),
    ColorCardModel(colorNumber: 5, colorName: 'Pink', colorCode: '#ED858E', colorDescription: '부드럽고 절제된 느낌을 나타내요. 무제한적인 사랑을 의미하며 희망, 감성, 로맨스를 전달해요.'),
    ColorCardModel(colorNumber: 6, colorName: 'Orange', colorCode: '#ED772F', colorDescription: '따뜻하며 활력감, 에너지를 제공해요. 빨간색의 열정과 노란색의 친근함이 섞여 있어서 동기 부여, 생을 사랑하는 느낌을 전달해요.'),
    ColorCardModel(colorNumber: 7, colorName: 'Yellow', colorCode: '#FDCB5C', colorDescription: '햇빛, 기쁨, 따뜻함을 상징해요. 친근감과 자신감을 제공해요. 하지만 약간의 불안감도 내포하고 있어요.'),
    ColorCardModel(colorNumber: 8, colorName: 'Red', colorCode: '#F13E69', colorDescription: '열정, 강렬함, 호전적인 느낌을 나타내요. 사랑, 자신감, 열정, 화 등 긍정적이고 부정적인 면 모두를 상징해요.'),
  ];
  List<StoryCardModel> storyCards = [
    StoryCardModel(
      colorNumber: 8,
      question: 'Q1. 질문은 어떻게 만들어지나요?',
      description: "저희 MUSIQ는 심리학 기반 질문과 일상 기반 질문을 나누어 내부적인 회의를 거친 뒤 질문을 제작합니다. \n\n참고 문헌으로는 '인간행동과 심리학', '질문의 힘' 등이 있습니다.",
      emoji: "🥸",
    ),
    StoryCardModel(
      colorNumber: 2,
      question: 'Q2. 음악별 색은 어떻게 정해지나요?',
      description: "각각의 음악에 대해서 Spotify가 제공하는 여러 가지 정보가 있습니다. 그 정보들을 분석하여 음악의 분위기를 결정하고, 색채 심리학에 기반하여 색상을 부여합니다.\n\n자세한 내용은 '다채로워요' 탭을 참고해주세요!",
      emoji: "😎",
    ),
    StoryCardModel(
      colorNumber: 1,
      question: 'Q3. 개인정보는 어떻게 보호하나요?',
      description: "저희 MUSIQ는 서비스 이용에 필요한 최소한의 개인정보만을 암호화하여 보관하고 있습니다. 곡 재생 관련 정보는 Spotify에 제공될 수 있습니다.\n\n자세한 사항은 아래 링크를 참고해주세요!",
      emoji: "🤫",
    ),
    StoryCardModel(
      colorNumber: 3,
      question: 'Q4. 제가 질문을 추가하고 싶어요!',
      description: "현재는 저희 MUSIQ가 엄선한 질문만을 제공하여, 사용자 개별 질문은 받지 않고 있습니다.\n\n하지만 MUSIQ 팀 내부에서 고려 중인 사항입니다. MUSIQ를 계속 지켜봐주세요!",
      emoji: "🙏",
    ),
    StoryCardModel(
      colorNumber: 5,
      question: 'Q5. 건의사항을 보내고 싶어요!',
      description: "많은 관심 가져주셔서 감사합니다!! 건의사항은 다음 이메일로 보내주세요!\n\nfrankwon11@cau.ac.kr",
      emoji: "😤",
    ),
  ];

  void showStoryPageTooltip() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    '궁금해요!',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'AppleSDGothicNeo',
                      color: AppColor.colorList[5],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    '💡 화면의 질문 카드를 눌러 MUSIQ에 대해 알아보아요!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "💡 다양한 피드백은 언제나 환영입니다! 좋은 의견 기다리고 있을게요 :)",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "💡 Since Sep. 2023; 'min-jp', 'frankwon11', 'eomchanu'",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 35),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColor.colorList[5])),
                        child: const Text(
                          "YES !",
                          style: TextStyle(fontFamily: 'AppleSDGothicNeo', color: Colors.white),
                        )),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "MUSIQ가 궁금해요!",
                      style: TextStyle(
                        fontFamily: 'AppleSDGothicNeo',
                        fontWeight: FontWeight.w500,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      '이렇게 만들었어요 :)',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 18,
                        fontFamily: 'AppleSDGothicNeo',
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                child: IconButton(
                  onPressed: () {
                    showStoryPageTooltip();
                  },
                  icon: Icon(CupertinoIcons.question_circle, color: Colors.grey.shade700),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ...storyCards
              .map((storyCard) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: StoryCard(
                      colorNumber: storyCard.colorNumber,
                      question: storyCard.question,
                      description: storyCard.description,
                      emoji: storyCard.emoji,
                    ),
                  ))
              .toList(),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '다음에 또 와요!',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 18,
                        fontFamily: 'AppleSDGothicNeo',
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: TextButton(
              child: const Text(
                '로그아웃',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                // 로그아웃 시
                navigatorKey.currentState!.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
