import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TooltipIconWidget extends StatelessWidget {
  const TooltipIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
      child: IconButton(
        onPressed: () {},
        icon: Icon(CupertinoIcons.question_circle, color: Colors.grey.shade700),
      ),
    );
  }
}
