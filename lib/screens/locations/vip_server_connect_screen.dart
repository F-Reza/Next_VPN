import 'package:next_vpn_lite/helpers/ad_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/native_ad_controller.dart';
import '../../helpers/pref.dart';
import '../../main.dart';
import '../../models/vpn_status.dart';
import '../../services/vpn_engine.dart';
import '../../widgets/count_down_timer.dart';
import '../../widgets/home_card.dart';


class VipServerConnectScreen extends StatefulWidget {
  VipServerConnectScreen({super.key});

  @override
  State<VipServerConnectScreen> createState() => _VipServerConnectScreenState();
}

class _VipServerConnectScreenState extends State<VipServerConnectScreen> {
  final _controller = Get.put(HomeController());

  dynamic country;
  dynamic username;
  dynamic password;
  dynamic config;

  Future<void> loadStoredData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Update the UI with the retrieved data
    setState(() {
      // Retrieve data from SharedPreferences
      country = prefs.getString('country') ?? '';
      username = prefs.getString('username') ?? '';
      password = prefs.getString('password') ?? '';
      config = prefs.getString('config') ?? '';

      print(country);
      print(username);
      print(password);
      print(config);
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadStoredData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });

    return Scaffold(
      backgroundColor: Color(0xff453984),
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 5,
        title: Text('${country} server'),
        backgroundColor: Pref.isDarkMode?Color(0xFF2080ff):Color(0xff022766),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start, children: [
        //vpn button


        Obx(() => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _vpnButton(context),
            ],
          ),
        )),


      ]),
    );
  }

  //vpn button
  Widget _vpnButton(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20
    ),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: 30.h,),


          Text("Connecting Time",style: TextStyle(color: Colors.white70),),

          SizedBox(height: 5,),

          //count down timer
          Obx(() => CountDownTimer(
              startTimer:
              _controller.vpnState.value == VpnEngine.vpnConnected)),

          SizedBox(height: 15,),

          //button
          Semantics(
            button: true,
            child: InkWell(
              onTap: () {
                _controller.connectToVipServer(
                    country,
                    username,
                    password,
                    config
                );
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF2080ff).withOpacity(0.1)),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2080ff).withOpacity(0.3)),
                  child: Container(
                    width: mq.height * .14,
                    height: mq.height * .14,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF2080ff).withOpacity(0.6)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //icon
                        Icon(
                          Icons.power_settings_new,
                          size: 28,
                          color: Colors.white,
                        ),

                        SizedBox(height: 4),

                        //text
                        Text(
                          _controller.getButtonText,
                          style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10,),
          //connection status label
          Container(
            margin:
            EdgeInsets.only(top: mq.height * .015, bottom: mq.height * .02),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              _controller.vpnState.value == VpnEngine.vpnDisconnected
                  ? 'Not Connected'
                  : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
              style: TextStyle(fontSize: 12.5, color: Colors.white,fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 25,),

        ],
      ),
    ),
  );
}
