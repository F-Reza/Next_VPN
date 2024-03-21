import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helpers/pref.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pref.isDarkMode?Color(0xFF2080ff):Colors.white,
      body: ListView(
        children: [
          Card(
            color: Pref.isDarkMode?Color(0xFF1e1f24):Color(0xFF404040),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8, // Set the height to half of the screen
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Privacy Policy",style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white.withOpacity(0.85),
                      ),),
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(Icons.cancel_outlined,color: Colors.white,)),

                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",style:
                    TextStyle(fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                      letterSpacing: 0.3,
                      color: Colors.white.withOpacity(0.85),
                    ),
                    textAlign: TextAlign.justify,
                  ),



                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
