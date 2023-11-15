import 'package:flutter/material.dart';

class ColorMusicCard extends StatelessWidget {
  final String cover, title, artist;
  const ColorMusicCard(
      {super.key,
      required this.cover,
      required this.title,
      required this.artist});

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
              SizedBox(
                height: 50,
                width: 50,
                child: Image.network(
                  cover,
                  headers: const {
                    "User-Agent":
                        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                  },
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 240,
                    child: Text(title,
                        style: const TextStyle(
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 240,
                    child: Text(
                      artist,
                      style: const TextStyle(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white),
                    ),
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
