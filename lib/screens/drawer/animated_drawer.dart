import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:next_vpn_lite/screens/landing/home_screen.dart';
import 'package:next_vpn_lite/screens/network/network_test_screen.dart';
import 'package:next_vpn_lite/screens/policy/privacy_policy.dart';
import 'package:next_vpn_lite/screens/share/share_with_friend_screen.dart';
import 'package:next_vpn_lite/screens/speed_test/speed_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../helpers/ad_helper.dart';
import '../../helpers/config.dart';
import '../../helpers/pref.dart';
import '../../widgets/customer_support_alert_dialogue.dart';
import '../../widgets/rate_us_alert_dialog.dart';
import '../../widgets/watch_ad_dialog.dart';

class AnimatedDrawerScreen extends StatefulWidget {
  @override
  _AnimatedDrawerScreenState createState() => _AnimatedDrawerScreenState();
}

class _AnimatedDrawerScreenState extends State<AnimatedDrawerScreen> {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  static _urlLauncher() async{
    const url = 'https://www.facebook.com/NextDigitOfficial/';
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pref.isDarkMode?Color(0xFF2080ff):Color(0xFF2D2D2D),
      appBar: AppBar(
        backgroundColor: Pref.isDarkMode?Color(0xFF2080ff):Color(0xFF2D2D2D),
        elevation: 0,
        centerTitle: true,
        title: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText('NEXT VPN',
              textStyle: TextStyle(color:Colors.white,
                letterSpacing: 5,
                fontSize: 16, fontWeight: FontWeight.w400,
                ),
            ),
          ],
          isRepeatingAnimation: true,
          repeatForever: true,
          pause: const Duration(milliseconds: 1000),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
          onTap: () {
            print("Tap Event");
          },
        ),
        leading: IconButton(
          icon: Icon(Icons.menu,color: Pref.isDarkMode? Colors.white:Colors.white,),
          onPressed: () {
            zoomDrawerController.toggle!();
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                //ad dialog

                if (Config.hideAds) {
                  Get.changeThemeMode(
                      Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                  Pref.isDarkMode = !Pref.isDarkMode;
                  return;
                }

                Get.dialog(WatchAdDialog(onComplete: () {
                  //watch ad to gain reward
                  AdHelper.showRewardedAd(onComplete: () {
                    setState(() {
                      Get.changeThemeMode(Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                      Pref.isDarkMode = !Pref.isDarkMode;
                    });
                  });
                }));
              },
              icon: Icon(Icons.brightness_medium, size: 26,color: Pref.isDarkMode? Colors.white:Colors.white,),
          ),

        ],
      ),
      body: ZoomDrawer(
        controller: zoomDrawerController,
        menuScreen: MenuScreen(),
        mainScreen: HomeScreen(),
        borderRadius: 24.0,
        angle: -10.0,
        showShadow: true,
        drawerShadowsBackgroundColor: Color(0xFF2080ff),
        slideWidth: MediaQuery.of(context).size.width * 0.75,
      ),

      bottomNavigationBar: Container(
        alignment: Alignment.center,
        color: Color(0xFF2080ff),
        height: 25,
        child: InkWell(
          onTap: () => _urlLauncher(),
          child: Text('Next Digit',style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pref.isDarkMode?Color(0xFF1e1f24):Color(0xFF7c7a8c),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: CircleAvatar(backgroundColor: Pref.isDarkMode? Colors.pinkAccent : Colors.black,
              child: Icon(Icons.home, color: Colors.white,),
            ),
            title: Text('Home',style: TextStyle(color: Pref.isDarkMode?Colors.pinkAccent:Colors.black,fontSize: 16.sp),),
            onTap: () {

              // Handle network info navigation
            },
          ),
          ListTile(
            leading: CircleAvatar(backgroundColor: Pref.isDarkMode?Color(0xFF2080ff) :Color(0xFF3F3F3F),
                child: Icon(Icons.speed,color: Colors.white,)),
            title: Text('Speed Test',style: TextStyle(color: Pref.isDarkMode?Colors.white:Colors.white,fontSize: 16.sp),),
            onTap: () {
              Get.to(()=>SpeedTestScreen(),transition: Transition.rightToLeft);
              // Handle network info navigation
            },
          ),
          ListTile(
            leading: CircleAvatar(backgroundColor: Pref.isDarkMode?Color(0xFF2080ff) :Color(0xFF3F3F3F),
                child: Icon(Icons.network_cell,color: Colors.white,)),
            title: Text('Network Info',style: TextStyle(color: Pref.isDarkMode?Colors.white:Colors.white,fontSize: 16.sp),),
            onTap: () {
              Get.to(()=>NetworkTestScreen(),transition: Transition.rightToLeft);
              // Handle network info navigation
            },
          ),
          ListTile(
            leading: CircleAvatar(backgroundColor: Pref.isDarkMode?Color(0xFF2080ff) :Color(0xFF3F3F3F),
                child: Icon(Icons.people_outline,color: Colors.white,)),
            title: Text('Invite Friends',style: TextStyle(color: Pref.isDarkMode?Colors.white:Colors.white,fontSize: 16.sp),),
            onTap: () {
              Get.to(()=>ShareWithFriendsScreen(),transition: Transition.rightToLeft);
              // Handle network info navigation
            },
          ),
          ListTile(
            leading: CircleAvatar(backgroundColor: Pref.isDarkMode?Color(0xFF2080ff) :Color(0xFF3F3F3F),
                child: Icon(Icons.support,color: Colors.white,)),
            title: Text('Customer Support',style: TextStyle(color: Pref.isDarkMode?Colors.white:Colors.white,fontSize: 16.sp),),
            onTap: () {
              customerSupportAlertDialogue(context);

              // Handle network info navigation
            },
          ),
          ListTile(
            leading: CircleAvatar(backgroundColor: Pref.isDarkMode?Color(0xFF2080ff) :Color(0xFF3F3F3F),
                child: Icon(Icons.star,color: Colors.white,)),
            title: Text('Rate us',style: TextStyle(color: Pref.isDarkMode?Colors.white:Colors.white,fontSize: 16.sp),),
            onTap: () {
              RateUsAlertDialog(context);
              // Handle network info navigation
            },
          ),
          ListTile(
            leading: CircleAvatar(backgroundColor: Pref.isDarkMode?Color(0xFF2080ff) :Color(0xFF3F3F3F),
                child: Icon(Icons.privacy_tip,color: Colors.white,)),
            title: Text('Privacy Policy',style: TextStyle(color: Pref.isDarkMode?Colors.white:Colors.white,fontSize: 16.sp),),
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>NetworkTestScreen()));
              // Handle network info navigation
              showBottomSheet(
                context: context,
                builder: (context) {
                  return const PrivacyPolicy();
                },
              );
            },
          ),

        ],
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Main Content Goes Here',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
