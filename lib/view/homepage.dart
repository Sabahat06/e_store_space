
import 'package:e_store_space/view/home%20screen%20and%20tab%20seller/buyer_screen_tab_seller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/controller/page_controller.dart';
import 'package:e_store_space/view/home_screen_tabs/cart_screen_tab.dart';
import 'package:e_store_space/widgets/navigation_bar.dart';
import 'home screen and tab seller/account_screen_tab_seller.dart';
import 'home screen and tab seller/home_screen_tab_seller.dart';
import 'home screen and tab seller/notification_tab_seller.dart';
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
  HtmlPageController htmlPageController = Get.put(HtmlPageController());

  final List _tabs =  [
    HomeScreenTab(),
    FavoriteScreenTab(),
    CartScreenTab(),
    AccountScreenTab(),
  ];

  final List _tabs_seller =  [
    HomeScreenTabSeller(),
    NotificationScreenTabSeller(),
    BuyerScreenTabSeller(),
    AccountScreenTabSeller(),
  ];


  @override
  Widget build(BuildContext context) {
    // FCM.configureFCM();
    // getToken();
    return Scaffold(
//      appBar: MyAppBarWidgets().getMyAppBar(),
      body:Obx(
        ()=>bottomBarController.isSeller.value
            ?  _tabs_seller[bottomBarController.currentBNBIndex.value]
            : _tabs[bottomBarController.currentBNBIndex.value]
      ),
      bottomNavigationBar: BottomNavigateBar(),
    );
  }
}