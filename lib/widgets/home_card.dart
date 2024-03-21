import 'package:flutter/material.dart';

import '../main.dart';

//card to represent status in home screen
class HomeCard extends StatelessWidget {
  final String? title, subtitle;
  final Widget icon;
  dynamic color;

   HomeCard(
      {super.key,
      required this.title,
        this.color,
       this.subtitle,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: mq.width * .45,
        child: Column(
          children: [
            //icon
            icon,

            //for adding some space
            const SizedBox(height: 6),

            //title
            Text(title.toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: color??Colors.white)),

            //for adding some space
            const SizedBox(height: 6),

            //subtitle
            subtitle!=null?Text(
              subtitle.toString(),
              style: TextStyle(
                  color: color?? Colors.white54,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ):SizedBox.shrink(),
          ],
        ));
  }
}
