import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/cart/shop_cart_screen_controller.dart';
import 'package:e_store_space/controller/cart_controller.dart';
import 'package:e_store_space/controller/product_controller.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/settings/color_palates.dart';
import 'package:e_store_space/view/homepage.dart';
import 'package:e_store_space/view/product/cart_screen.dart';


class MyAppBarWidgets {
  String title;
  MyAppBarWidgets({this.title});
  CartControllerNew cartController = Get.find();
  PreferredSizeWidget getMyAppBar(){
    return  AppBar(
      leading: title == 'Products' ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,) : Container(),
      leadingWidth: title == 'Products' ? 30 : 0,
      title: Text(title),
      actions: [
        GestureDetector(
          onTap: ()=>Get.to(CartScreen()),
          child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                    icon: Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                      // Get.to(StepperBar());
                      Get.to(CartScreen());
                    },
                    color: Colors.black
                ),
                Obx(
                ()=> Stack(
                    alignment: Alignment.center,
                    children: [
                      cartController.cart.items.length == 0
                          ? Container()
                          : const Icon(
                        Icons.circle,
                        color: Colors.white,
                      ),
                      cartController.cart.items.length == 0
                          ?Container()
                          : Text(
                        (cartController.cart.items.length).toString(),
                        style: const TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ]
          ),
        )
      ],
    );
  }
}