import 'package:flutter/material.dart';
import 'package:musiq_front/services/api_service.dart';
import 'package:musiq_front/style.dart';

class MusicCard extends StatefulWidget {
  final int question_id, initial_color;
  final String music_id, cover, title, artist;
  final Function(int) onColorChanged;

  const MusicCard(
      {super.key, required this.question_id, required this.initial_color, required this.music_id, required this.cover, required this.title, required this.artist, required this.onColorChanged});

  @override
  State<MusicCard> createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
  bool _isAdded = false;
  late int color = widget.initial_color;

  void _updateColor() async {
    int newColor = await ApiService.postSearchMusic(widget.question_id, widget.music_id);
    setState(() {
      color = newColor;
      widget.onColorChanged(newColor);
    });
  }

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
                  widget.cover,
                  headers: const {
                    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
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
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 190,
                    child: Text(
                      widget.artist,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                    ),
                  )
                ],
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColor.colorList[color], shape: const CircleBorder(), minimumSize: const Size(15, 15)),
            onPressed: () {
              setState(() {
                _updateColor();
                _isAdded = true;
              });
            },
            child: _isAdded
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 20,
                  )
                : const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
          )
        ],
      ),
    );
  }
}
