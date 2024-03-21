import 'package:next_vpn_lite/controllers/home_ads_controller.dart';
import 'package:next_vpn_lite/helpers/home_ads.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../controllers/home_controller.dart';
import '../../helpers/pref.dart';
import '../../main.dart';
import '../../models/vpn_status.dart';
import '../../services/vpn_engine.dart';
import '../../widgets/count_down_timer.dart';
import '../../widgets/home_card.dart';
import '../locations/location_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = Get.put(HomeController());

  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  final homeAds = Get.put(HomeAdsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///Add listener to update vpn state
    ///
    homeAds.ad = HomeAds.loadNativeAd(adController: homeAds);
    ///
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });

    return Scaffold(

      //body
      backgroundColor: Pref.isDarkMode?Color(0xFF1e1f24):Color(0xFF2D2D2D),
      body: Stack(
        children: [

          Container(
           padding: EdgeInsets.only(bottom: 90),
            child: ListView(
                children: [
              //vpn button
              Container(
                color: Color(0xFF1e1f24),
                height: 500,
                width: double.infinity,
                child:    Obx(() => Column(
                  children: [
                    _vpnButton(),
                  ],
                )),
              ),

              _changeLocation(context),
              const SizedBox(height: 5,),

              Card(
                color: Pref.isDarkMode?Color(0xFF2080ff):Color(0xFF797979),
                elevation: 0,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10
                    ),
                    child:
                        Obx(() =>  Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xFF1e1f24),
                                  ),
                                  height: 50,
                                  width: 80,
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Color(0xFF2080ff),
                                    child: _controller.vpn.value.countryLong.isEmpty
                                        ? Icon(Icons.vpn_lock_rounded,
                                        size: 30, color: Colors.white)
                                        : null,
                                    backgroundImage: _controller.vpn.value.countryLong.isEmpty
                                        ? null
                                        : AssetImage(
                                        'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png'),
                                  ),
                                ),
                                SizedBox(width: 10,),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_controller.vpn.value.countryLong.isEmpty
                                        ? 'Country'
                                        : _controller.vpn.value.countryLong,style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500
                                    ),),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("FREE",style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            //ping time
                            Expanded(
                              child: HomeCard(
                                  title: _controller.vpn.value.countryLong.isEmpty
                                      ? '100 ms'
                                      : '${_controller.vpn.value.ping} ms',
                                  icon: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Color(0xFF1e1f24),
                                    child: Icon(Icons.equalizer_rounded,
                                        size: 18,color: Colors.white,),
                                  )),
                            ),

                          ],
                        ), ),

                  ),
                ),
              )

            ]),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(child: homeAds.ad != null && homeAds.adLoaded.isTrue
                ? StatefulBuilder(
                  builder: (context,setState) {
                    return Container(
                    height: 85, child: AdWidget(ad: homeAds.ad!));
                  }
                )
                : null,))
        ],
      ),
    );
  }

  //vpn button
  Widget _vpnButton() => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 20
    ),
    child: Column(
          children: [

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
                  _controller.connectToVpn();
                },
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2580ff).withOpacity(.1)),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF2070ff).withOpacity(.3)),
                    child: Container(
                      width: mq.height * .14,
                      height: mq.height * .14,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _controller.vpnState =='connected'?
                          Color(0xFF2770ff).withOpacity(0.8): Color(0xFF2990ff ).withOpacity(0.6)),
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
              decoration: BoxDecoration(
                  color: _controller.vpnState =='connected'? Colors.pink: Color(0xFF2080ff), borderRadius: BorderRadius.circular(15)),
              child: Text(
                _controller.vpnState.value == VpnEngine.vpnDisconnected
                    ? 'Not Connected'
                    : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
                style: TextStyle(fontSize: 12.5, color: Colors.white,fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 25,),
            StreamBuilder<VpnStatus?>(
                initialData: VpnStatus(),
                stream: VpnEngine.vpnStatusSnapshot(),
                builder: (context, snapshot) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //download
                      HomeCard(
                          title: '${snapshot.data?.byteIn ?? '0 kbps'}',
                          subtitle: 'DOWNLOAD',
                          icon: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.green,
                            child: Icon(Icons.arrow_downward_rounded,
                                size: 20, color: Colors.white),
                          )),


                      //upload
                      HomeCard(
                          title: '${snapshot.data?.byteOut ?? '0 kbps'}',
                          subtitle: 'UPLOAD',
                          icon: CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFF2770ff),
                            child: Icon(Icons.arrow_upward_rounded,
                                size: 20, color: Colors.white),
                          )),
                    ],
                  ),
                )),
          ],
        ),
  );

  //bottom nav to change location
  Widget _changeLocation(BuildContext context) => Semantics(
        button: true,
        child: InkWell(
  onTap: () => Get.to(() => LocationScreen(),transition: Transition.rightToLeft),
  child: Container(
      color: Pref.isDarkMode?Colors.pinkAccent:Color(0xFF7c7a8c),
      padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
      height: 60,
      child: Row(
        children: [
          //icon
          Icon(CupertinoIcons.globe, color: Colors.white, size: 28),

          //for adding some space
          SizedBox(width: 10),

          //text
          Text(
            'Change Location',
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),

          //for covering available spacing
          Spacer(),

          //icon
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.keyboard_arrow_right_rounded,
                color: Color(0xFF2080ff), size: 26),
          )
        ],
      )),
        ),
      );
}
