import 'package:flutter/material.dart';

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
      height: 130,
      width: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 90,
            width: 90,
            child: Image.network(
              cover,
              headers: const {
                "User-Agent":
                    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
              },
            ),
          ),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          Text(
            artist,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
