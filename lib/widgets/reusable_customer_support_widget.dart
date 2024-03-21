import 'package:next_vpn_lite/helpers/pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ReusableCustomerSupportWidget extends StatelessWidget {
  ReusableCustomerSupportWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.image,
  });

  VoidCallback? onTap;
  String? title;
  String? image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 32.w),
        height: 50.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(1.0, 3.0),
                color: Colors.blue.withOpacity(0.2),
                blurRadius: 4,
              ),
            ]),
        child: Row(
          children: [
            Image.asset(
              "$image",
              height: 24.h,
              width: 24.w,
            ),
            SizedBox(
              width: 16.w,
            ),
            Text(
              "$title",
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
