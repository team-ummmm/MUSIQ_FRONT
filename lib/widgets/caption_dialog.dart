import 'package:flutter/material.dart';
import 'package:musiq_front/style.dart';

class CaptionDialog extends StatefulWidget {
  final Function(String) updateCaption;

  const CaptionDialog({required this.updateCaption, super.key});

  @override
  State<CaptionDialog> createState() => _CaptionDialogState();
}

class _CaptionDialogState extends State<CaptionDialog> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.backgroudColor.withOpacity(0.9),
      shadowColor: Colors.black,
      title: const Text(
        '한마디 남겨주세요!',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      content: TextField(
        controller: _textEditingController,
        // decoration: ,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // 팝업을 닫고 입력한 텍스트를 출력
            widget.updateCaption(_textEditingController.text);
            Navigator.of(context).pop(_textEditingController.text);
          },
          child: const Text(
            '확인',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () {
            // 팝업을 닫기만 함
            Navigator.of(context).pop();
          },
          child: const Text('취소', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
