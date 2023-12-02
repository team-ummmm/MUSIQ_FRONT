import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:musiq_front/models/color_card_model.dart';
import 'package:musiq_front/style.dart';
import 'package:musiq_front/widgets/color_card.dart';
import 'package:musiq_front/widgets/cube_painter.dart';
import 'package:musiq_front/widgets/point_cloud_painter.dart';

class ColorPage extends StatefulWidget {
  const ColorPage({super.key});

  @override
  State<ColorPage> createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  void _onSceneCreated(Scene scene) {
    scene.camera.position.x = 6;
    scene.camera.position.y = 8;
    scene.camera.target.y = 1;
    scene.world.add(Object(scale: Vector3(6.0, 6.0, 6.0), fileName: 'assets/cube/colorCube.obj'));
  }

  List<ColorCardModel> colorCards = [
    ColorCardModel(colorNumber: 1, colorName: 'Sky Blue', colorCode: '#3897F0', colorDescription: '신뢰성을 보여주며, 편안한 감정을 전달해요. 하지만 차가운 컬러이기에 거리감과 슬픈 감정도 함께 제공해요.'),
    ColorCardModel(colorNumber: 2, colorName: 'Magenta', colorCode: '#B638F2', colorDescription: '차분한 화려함을 지니고 있어요. 빨강과 파랑의 경쟁의 결과로, 자신감과 자존감을 나타내요. 하지만 자아도취에 빠질 수도 있어요.'),
    ColorCardModel(colorNumber: 3, colorName: 'Light Green', colorCode: '#63CB24', colorDescription: '자연, 균형, 조화를 나타내며, 신선함과 만족감을 제공해요. 대체로 긍정적인 경험을 나타내요.'),
    ColorCardModel(colorNumber: 4, colorName: 'Purple', colorCode: '#7637F4', colorDescription: '미스테리함과 화려함을 지니고 있어요. 빨강과 파랑의 조화를 이루고 있어 안정을 느낄 수 있지만, 산만해질 수도 있어요.'),
    ColorCardModel(colorNumber: 5, colorName: 'Coral Pink', colorCode: '#ED858E', colorDescription: '부드럽고 절제된 느낌을 나타내요. 무제한적인 사랑을 의미하며 희망, 감성, 로맨스를 전달해요.'),
    ColorCardModel(colorNumber: 6, colorName: 'Orange', colorCode: '#ED772F', colorDescription: '따뜻하며 활력감, 에너지를 제공해요. 빨간색의 열정과 노란색의 친근함이 섞여 있어서 동기 부여, 생을 사랑하는 느낌을 전달해요.'),
    ColorCardModel(colorNumber: 7, colorName: 'Yellow', colorCode: '#FDCB5C', colorDescription: '햇빛, 기쁨, 따뜻함을 상징해요. 친근감과 자신감을 제공해요. 하지만 약간의 불안감도 내포하고 있어요.'),
    ColorCardModel(colorNumber: 8, colorName: 'Vivid Red', colorCode: '#F13E69', colorDescription: '열정, 강렬함, 호전적인 느낌을 나타내요. 사랑, 자신감, 열정, 화 등 긍정적이고 부정적인 면 모두를 상징해요.'),
  ];
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
                      "다채로워요",
                      style: TextStyle(
                        fontFamily: 'AppleSDGothicNeo',
                        fontWeight: FontWeight.w500,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      '눌러서 확인해봐요!',
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
              IconButton(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                onPressed: () {},
                icon: Icon(CupertinoIcons.question_circle, color: Colors.grey.shade700),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // 여기 밑의 컬러 카드
          ...colorCards
              .map((colorCard) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: ColorCard(
                      // colorCards 리스트로부터 ColorCard 생성
                      colorNumber: colorCard.colorNumber,
                      colorCode: colorCard.colorCode,
                      colorName: colorCard.colorName,
                      colorDescription: colorCard.colorDescription,
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
                      '돌려서 확인해봐요!',
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
          Center(
            child: SizedBox(
              width: 350,
              height: 350,
              child: Cube(
                onSceneCreated: _onSceneCreated,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
