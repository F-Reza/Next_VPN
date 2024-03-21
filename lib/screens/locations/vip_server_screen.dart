import 'dart:convert';
import 'package:next_vpn_lite/apis/vip_server_api.dart';
import 'package:next_vpn_lite/screens/locations/vip_server_connect_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/home_controller.dart';
import '../../helpers/pref.dart';

class VipServerScreen extends StatefulWidget {
   VipServerScreen({Key? key}) : super(key: key);

  @override
  State<VipServerScreen> createState() => _VipServerScreenState();
}

class _VipServerScreenState extends State<VipServerScreen> {
  final VipServerController vipServerController = Get.put(VipServerController());

  @override
  void initState() {
    // TODO: implement initState
    vipServerController.fetchData();
    super.initState();
  }

  final controller = Get.find<HomeController>();


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
      Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
              () => vipServerController.isLoading.value
              ? Center(child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: CircularProgressIndicator(),
              ))
              : vipServerController.isLoading.value == true? Column(
                  children: [
              for (var server in vipServerController.vipServers)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 2,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    color: Pref.isDarkMode?Color(0xFF2080ff):Colors.white,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      onTap: () async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();

                        // Store the values in SharedPreferences
                        prefs.setString('country', server.country);
                        prefs.setString('username', server.username);
                        prefs.setString('password', server.password);
                        prefs.setString('config', server.config);
                        // controller.connectToVipServer(
                        //     server.country,
                        //     server.username,
                        //     server.password,
                        //     server.config
                        // );
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>VipServerConnectScreen()));
                      },
                      leading:
                      server.image!=null?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.memory(
                          Uint8List.fromList(
                              Base64Decoder().convert(server.image.split(',')[1])
                          ),
                          height:  40.h,
                          width:  50.w,
                          fit: BoxFit.cover,
                        ),
                      ):
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset("assets/images/placeholder.jpg",
                          height:  40.h,
                          width:  50.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text('${server.country}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 4),
                          Icon(CupertinoIcons.location_solid, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ) : Center(child: Text('data not fount!',style: TextStyle(color: Pref.isDarkMode? Colors.grey: Colors.white),)),
        ),
      ],
    ),

      ],
    );
  }
}
//ccccff