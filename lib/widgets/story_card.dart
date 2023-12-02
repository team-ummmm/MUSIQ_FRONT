import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';

class StoryCard extends StatefulWidget {
  final int colorNumber;
  final String question, description, emoji;
  const StoryCard({
    super.key,
    required this.colorNumber,
    required this.question,
    required this.description,
    required this.emoji,
  });

  @override
  State<StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white70,
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
                        const SizedBox(height: 10),
                        Text(
                          'A.',
                          style: TextStyle(fontSize: 34, fontFamily: 'AppleSDGothicNeo', fontWeight: FontWeight.bold, color: AppColor.colorList[widget.colorNumber]),
                        ),
                        const SizedBox(height: 35),
                        Text(
                          widget.description,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const SizedBox(height: 35),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColor.colorList[widget.colorNumber])),
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
        },
        child: Stack(
          children: [
            Column(children: [
              const SizedBox(
                height: 48,
              ),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColor.colorList[widget.colorNumber]),
                height: 100,
                width: 340,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        widget.question,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'AppleSDGothicNeo',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
            ]),
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColor.colorList[widget.colorNumber]),
                height: 60,
                width: 60,
              ),
            ),
            Positioned(
              top: 23,
              left: 22.7,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
                height: 55,
                width: 55,
                child: Center(
                  child: Text(
                    widget.emoji,
                    style: const TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
