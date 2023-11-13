import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';

class MusicCard extends StatelessWidget {
  final String id, cover, title, artist;
  const MusicCard(
      {super.key,
      required this.id,
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
                    width: 190,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 190,
                    child: Text(
                      artist,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade700),
                    ),
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
