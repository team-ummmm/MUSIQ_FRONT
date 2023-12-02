import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';

class ColorCard extends StatefulWidget {
  final int colorNumber;
  final String colorName, colorCode, colorDescription;
  const ColorCard({
    super.key,
    required this.colorNumber,
    required this.colorName,
    required this.colorCode,
    required this.colorDescription,
  });

  @override
  State<ColorCard> createState() => _ColorCardState();
}

class _ColorCardState extends State<ColorCard> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isClicked = !isClicked;
        });
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColor.colorList[widget.colorNumber]),
        height: 180,
        width: 340,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.colorName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'AppleSDGothicNeo',
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(width: 10),
                  isClicked
                      ? Column(
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              widget.colorCode,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontFamily: 'AppleSDGothicNeo',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
              const SizedBox(height: 10),
              isClicked
                  ? Text(
                      widget.colorDescription,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'AppleSDGothicNeo',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

// '신뢰성을 보여주며, 편안한 감정을 전달해요. 하지만, 차가운 컬러이기에 거리감과 슬픈 감정도 함께 제공해요.',