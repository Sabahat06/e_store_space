import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/settings/color_palates.dart';
import 'package:e_store_space/view/order%20screen/place_order_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/used_mobile_controller.dart';
import 'package:e_store_space/models/used_mobile_model.dart';
import 'package:e_store_space/view/used_mobiles_request_screen.dart';
import 'package:e_store_space/widgets/my_appbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationScreenTabSeller extends StatelessWidget {
  BottomBarController bottomBarController = Get.find();
  RxInt quantity = 0.obs;
  @override

  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white, iconSize: 0,),
          leadingWidth: 5,
          centerTitle: true,
          title: Column(
            children: [
              Text('Your Cart'),
              Text('2 Items', style: TextStyle(fontSize: 15.sp, color: Colors.black), ),
            ],
          ),
        ),
      body: Container(child: Center(child: Text("Favorite Tab"),),)
    );
  }

  MyProduct(){
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
                Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          quantity.value++;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: Colors.blue
                          ),
                          child: Icon(Icons.add, size: 25.w, color: Colors.white,),
                        ),
                      ),
                      SizedBox(height: 4.h,),
                      Text(quantity.value.toString(), style: TextStyle(fontSize: 14.sp, color: Colors.black), ),
                      SizedBox(height: 4.h,),
                      GestureDetector(
                        onTap: () {
                          quantity.value--;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: Colors.blue
                          ),
                          child: Icon(Icons.remove, size: 25.w, color: Colors.white,),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
