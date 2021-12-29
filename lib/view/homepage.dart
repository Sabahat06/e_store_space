
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
import 'package:e_store_space/view/home_screen_tabs/cart_screen_tab.dart';
import 'package:e_store_space/view/order%20screen/order_status_screen.dart';
import 'package:e_store_space/widgets/my_appbar.dart';
import 'package:e_store_space/widgets/navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen_tabs/account_Screen_tab.dart';
import 'home_screen_tabs/home_screen_tab.dart';
import 'home_screen_tabs/favorite_screen_tab.dart';

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
    FavoriteScreenTab(),
    CartScreenTab(),
    AccountScreenTab(),

  ];


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