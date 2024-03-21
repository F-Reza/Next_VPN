import 'package:next_vpn_lite/screens/drawer/animated_drawer.dart';
import 'package:next_vpn_lite/screens/onbgoarding/slider_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoard extends StatefulWidget {
  static const String routeName = "/onboard";
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int _currentPage = 0;
  final PageController _controller = PageController();

  final List<Widget> _pages = [
    const SliderScreen(
        title: "Quick \nand Easy to Start",
        description: "NEXT VPN & Secure Proxy provide fastest vpn server",
        short: "free forever",
        image: "assets/lottie/welcome.json"),
    const SliderScreen(
        title: "Explore \nall the Exciting Locations",
        description: "Select a location and get connected",
        short: "within a single tap",
        image: "assets/lottie/explore.json"),
    const SliderScreen(
        title: "Unblock Restricted \ncontent",
        description: "Let's enjoy any content all over the world and",
        short: "secure connection",
        image: "assets/lottie/unblock.json"),
  ];

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: _onchanged,
            controller: _controller,
            itemCount: _pages.length,
            itemBuilder: (context, int index) {
              return _pages[index];
            },
          ),
          Positioned(
            top: 580.h,
            left: 20.w,
            right: 20.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(_pages.length, (int index) {
                      return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 10.h,
                          width: (index == _currentPage) ? 30.w : 8.w,
                          margin: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 24.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: (index == _currentPage)
                                  ?  Color(0xFF2080ff)
                                  : Get.isDarkMode? Colors.white30: Colors.black54));
                    })),
                GestureDetector(
                  onTap: () async{

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString('firstTime', 'false');


                    (_currentPage == (_pages.length - 1))
                        ?
                   Get.offAll(AnimatedDrawerScreen())
                        : _controller.nextPage(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOutQuint);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: AnimatedContainer(
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 300),
                      height: 50.h,
                      width:
                      (_currentPage == (_pages.length - 1)) ? 270.w : 270.w,
                      decoration: BoxDecoration(
                          color: Color(0xFF2080ff),
                          borderRadius: BorderRadius.circular(10)),
                      child: (_currentPage == (_pages.length - 1))
                          ? Text(
                        "GET STARTED",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins-Light'),
                      )
                          : Text(
                        'NEXT ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}