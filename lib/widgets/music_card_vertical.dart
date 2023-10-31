import 'package:flutter/material.dart';

class MusicCardVertical extends StatelessWidget {
  final String cover, title, artist, color;

  const MusicCardVertical(
      {super.key,
      required this.cover,
      required this.title,
      required this.artist,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.withOpacity(0.2)),
            width: 90,
            height: 90,
          ),
          Text(
            title.length > 8 ? title.substring(0, 8) : title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          ),
          Text(
            artist.length > 15 ? artist.substring(0, 8) : artist,
            style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
