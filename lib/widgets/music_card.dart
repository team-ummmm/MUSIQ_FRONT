import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';

class MusicCard extends StatelessWidget {
  final String cover, title, artist, color;
  const MusicCard(
      {super.key,
      required this.cover,
      required this.title,
      required this.artist,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(width: 50, height: 50, color: Colors.blue),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black)),
                  Text(
                    artist,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  )
                ],
              ),
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.color2,
                  shape: const CircleBorder(),
                  minimumSize: const Size(15, 15)),
              onPressed: () {
                print('hi');
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ))
        ],
      ),
    );
  }
}
