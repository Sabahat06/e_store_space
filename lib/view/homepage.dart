
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:e_store_space/Utils/httpHelper.dart';
import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/controller/category_controller.dart';
import 'package:e_store_space/controller/product_controller.dart';
import 'package:e_store_space/main.dart';
import 'package:e_store_space/models/order_history_model.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/services/local_notification_service.dart';
import 'package:e_store_space/statics/static_var.dart';
import 'package:e_store_space/update_prompt/update_prompt_screen.dart';
import 'package:e_store_space/view/home_screen_tabs/used_devies_screen_tab.dart';
import 'package:e_store_space/view/order%20screen/order_status_screen.dart';
import 'package:e_store_space/widgets/my_appbar.dart';
import 'package:e_store_space/widgets/navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen_tabs/account_Screen_tab.dart';
import 'home_screen_tabs/home_screen_tab.dart';
import 'home_screen_tabs/product_screen_tab.dart';

class HomePage extends StatefulWidget {

  // AuthController authController = Get.put(AuthController());
  // final productScreenController = Get.put(ProductScreenController());
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  BottomBarController bottomBarController=Get.find();
  CategoryController categoryController = Get.put(CategoryController());

  final List _tabs = [
    HomeScreenTab(),
    ProductScreenTab(),
    UsedMobileScreenTab(),
    AccountScreenTab(),

  ];
  @override
  void initState() {
    _checkUpdates();
    super.initState();
  }

  ///checking updates using API \\\

  _checkUpdates() async{
    var latestVersion;
    int appVersion = await _getVersion();
    SharedPreferences pref = await SharedPreferences.getInstance();

    var response;
    try{
      response = await HttpHelper.post(body: {
        "app_update" : '1',
      });
      latestVersion = Platform.isAndroid? jsonDecode(response.body)["android_update"]
          :jsonDecode(response.body)["ios_update"];
      print("latest version: $latestVersion");
      pref.setString("latestVersion", latestVersion);
    }

    catch(e){}
    latestVersion = pref.getString("latestVersion");
    if(latestVersion!=null)
    {
      latestVersion = latestVersion.split(".")[0]+latestVersion.split(".")[1]+latestVersion.split(".")[2];
    }
    print("latest pref version: $latestVersion");
    if (latestVersion != null && appVersion != null && int.parse(latestVersion) > appVersion) // todo change the bool statement to >
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> UpdatePromptScreen()));

  }


  ///getting current version of the App
  Future<int> _getVersion() async {
    int version;
    List versions;
    final packageInfo = await PackageInfo.fromPlatform();
    print("Current version:"+packageInfo.version);
    versions= packageInfo.version.split(".");
    return int.parse(versions[0]+versions[1]+versions[2]);
  }



  @override
  Widget build(BuildContext context) {
    // FCM.configureFCM();
    // getToken();
    return Scaffold(
//      appBar: MyAppBarWidgets().getMyAppBar(),
      body:Obx(
        ()=>_tabs[bottomBarController.currentBNBIndex.value]
      ),
      bottomNavigationBar: BottomNavigateBar(),
    );
  }
}