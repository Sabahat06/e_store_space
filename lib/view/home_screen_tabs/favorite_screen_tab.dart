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

class FavoriteScreenTab extends StatelessWidget {
  BottomBarController bottomBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white, iconSize: 0,),
        leadingWidth: 5,
        title: const Text('Favorite', style: TextStyle(color: Colors.white),),
      ),
      body: bottomBarController.isSeller.value
          ? Container(child: Center(child: Text("Favorite Tab"),),)
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 25,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: MyProduct(context),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }

  MyProduct(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w, top: 8.0.w, bottom: 8.0.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.red.shade200,
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: Offset(2.0, 2.0),
            )
          ],
        ),
        child: Container(
            height: 90.h,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 75.h,
                      width: 75.w,
                      child: Image.asset("assets/image/image6.jpg")
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Product Name', style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),),
                      SizedBox(height: 5.h,),
                      Text('Price', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.blue),),
                    ],
                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outlined, color: Colors.red,) , iconSize: 30,),
                  IconButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialogWidget(
                              title: 'Remove Alert',
                              subTitle: "Are you sure to Remove from WishList?",
                              onPositiveClick: () {
                                Get.back();
                              },
                            );
                          }
                      );
                    },
                    icon: Icon(Icons.delete_outlined, color: Colors.red,) ,
                    iconSize: 30,
                  ),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outlined, color: Colors.red,) , iconSize: 30,),
                  //     SizedBox(height: 5.h,),
                  //     IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outlined, color: Colors.red,) , iconSize: 30,),
                  //   ],
                  // ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
