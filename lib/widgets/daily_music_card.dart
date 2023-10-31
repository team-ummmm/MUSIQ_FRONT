import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';

class DailyMusicCard extends StatelessWidget {
  final String cover, title, artist, color;
  const DailyMusicCard(
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
              // cover img.
              Container(width: 50, height: 50, color: Colors.blue),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  Text(
                    artist,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
