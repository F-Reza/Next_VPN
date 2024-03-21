import 'package:flutter/material.dart';

import '../helpers/pref.dart';
import '../main.dart';
import '../models/network_data.dart';

class NetworkCard extends StatelessWidget {
  final NetworkData data;

  const NetworkCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Pref.isDarkMode?Color(0xFF121526):Color(0xFF494949),
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: mq.height * .01),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(15),
          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

            //flag
            leading: Icon(data.icon.icon, color: data.icon.color, size: data.icon.size ?? 28),

            //title
            title: Text(data.title,style: TextStyle(color: Colors.white.withOpacity(0.85)),),

            //subtitle
            subtitle:  data.subtitle!= null? Text(data.subtitle.toString()
              ,style: TextStyle(color: Colors.white.withOpacity(0.85)),):SizedBox.shrink(),
          ),
        ));
  }
}
