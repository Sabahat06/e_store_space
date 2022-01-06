import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/widgets/AlertDialogeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/cart/shop_cart_screen_controller.dart';
import 'package:e_store_space/controller/cart_controller.dart';
import 'package:e_store_space/controller/category_controller.dart';
import 'package:e_store_space/models/sub_category_model.dart';
import 'package:e_store_space/settings/color_palates.dart';
import 'package:e_store_space/view/product/cart_screen.dart';
import 'package:e_store_space/view/product/product_screen.dart';
import 'package:e_store_space/widgets/my_appbar.dart';

class BuyerScreenTabSeller extends StatelessWidget {
  BottomBarController bottomBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white, iconSize: 0,),
        leadingWidth: 5,
        title: const Text('Buyer Request', style: TextStyle(color: Colors.white),),
      ),
      body: Container(child: Center(child: Text("Buyer Request"),),)
    );
  }
}
