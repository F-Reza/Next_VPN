import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../helpers/pref.dart';


class StarRatingController extends GetxController {
  RxDouble rating = 0.0.obs;

  void setRating(double value) {
    rating.value = value;
    update();
  }
}

class StarRating extends GetView<StarRatingController> {
  final int starCount;
  final double size;

  StarRating({this.starCount = 5, this.size = 30.0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        bool isFilled = index < controller.rating.value;
        return GestureDetector(
          onTap: () => controller.setRating(index + 1.0),
          child: Padding(
            padding: EdgeInsets.only(
              left: 5.w,
            ),
            child: Icon(
              isFilled ? Icons.star : Icons.star_border,
              color: isFilled
                  ? Colors.orange
                  :  Pref.isDarkMode? Colors.white70 : Colors.black54,
              size: size,
            ),
          ),
        );
      }),
    );
  }
}
