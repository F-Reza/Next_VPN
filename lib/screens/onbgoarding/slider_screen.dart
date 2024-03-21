import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SliderScreen extends StatelessWidget {
  final String title;
  final String description;
  final String short;
  final String image;

  const SliderScreen(
      {super.key, required this.title,
        required this.description,
        required this.image,
        required this.short});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 100.h, left: 20.w, right: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.only(top: 40.h,left: 16),
          //   child: Text(
          //     title,
          //     style: TextStyle(
          //         color: Colors.blue,
          //         fontSize: 18.sp,
          //         fontWeight: FontWeight.w500),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Center(
              child: Lottie.asset(
                image,
                height: 250.h,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Center(
              child: Text(
                "$description $short",
                style: TextStyle(
                  fontFamily: 'Poppins-Light',
                  color: Colors.black54,
                  fontSize: 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(top: 2.h),
          //   child: Center(
          //     child: Text(
          //       short,
          //       style: TextStyle(
          //         fontFamily: 'Poppins-Light',
          //         color: Colors.black54,
          //         fontSize: 16.sp,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}