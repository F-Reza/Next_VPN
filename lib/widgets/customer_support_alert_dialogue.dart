import 'package:next_vpn_lite/widgets/reusable_customer_support_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/pref.dart';

customerSupportAlertDialogue(BuildContext context) {
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Customer Support",style: TextStyle(
                        color: Pref.isDarkMode? Colors.white : Colors.white
                      ),
                      ),
                      IconButton(onPressed: (){
                        Get.back();
                      }, icon: Icon(Icons.cancel_outlined,color: Colors.white,)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                // ReusableCustomerSupportWidget(
                //   onTap: () async{
                //     String phoneNumber = '1234567890';  // Replace with the phone number you want to send a message to
                //     String url = 'sms:$phoneNumber';
                //     if (await canLaunch(url)) {
                //       await launch(url);
                //     } else {
                //       throw 'Could not launch $url';
                //     }
                //   },
                //   title: 'WhatsApp',
                //   image: 'assets/images/whatsapp.png',
                // ),
                // SizedBox(
                //   height: 8.h,
                // ),
                ReusableCustomerSupportWidget(
                  onTap: () async{
                    String email = 'info@gmail.com';  // Replace with the recipient's email address
                    String url = 'mailto:$email';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  title: 'Email',
                  image: 'assets/images/gmail.png',
                ),
                SizedBox(
                  height: 8.h,
                ),
                ReusableCustomerSupportWidget(
                  onTap: () async{
                    String phoneNumber = '01800000000';  // Replace with the phone number you want to call
                    String url = 'tel:$phoneNumber';
                    if (await canLaunch(url)) {
                    await launch(url);
                    } else {
                    throw 'Could not launch $url';
                    }
                  },
                  title: 'Call',
                  image: 'assets/images/telephone.png',
                ),
                SizedBox(
                  height: 8.h,
                ),
                ReusableCustomerSupportWidget(
                  onTap: () async{
                    String phoneNumber = '01800000000';  // Replace with the phone number you want to send a message to
                    String url = 'sms:$phoneNumber';
                    if (await canLaunch(url)) {
                    await launch(url);
                    } else {
                    throw 'Could not launch $url';
                    }
                  },
                  title: 'Message',
                  image: 'assets/images/comments.png',
                ),
              ],
            ),
          ),
        );
      });
}
