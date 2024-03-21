import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/rate_us_controller.dart';
import '../helpers/pref.dart';


RateUsAlertDialog(BuildContext context) {
  // final giveMoneyController = Get.find<TransactionInformationPageController>();

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          scrollable: true,
          backgroundColor: Pref.isDarkMode?Color(0xFF1e1f24) : Color(0xFF404040),
          alignment: Alignment.center,
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(onPressed: (){
                    Get.back();
                  }, icon: Icon(Icons.cancel_outlined,color: Colors.white,)),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Center(
                  child: GetBuilder<StarRatingController>(
                    init: StarRatingController(),
                    builder: (_) => StarRating(starCount: 5, size: 40.0,),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: InkWell(
                    onTap: () async{
                      const youtubeUrl = 'https://play.google.com/';  // Replace with your desired YouTube URL
                      if (await canLaunch(youtubeUrl)) {
                        await launch(youtubeUrl);
                      } else {
                        throw 'Could not launch $youtubeUrl';
                      }
                    },
                    child: Container(
                      height: 45.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        color: Color(0xFF2080ff),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Center(
                        child: Text(
                          "Rate Us",style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
              ],
            ),
          ),
        );
      });
}
