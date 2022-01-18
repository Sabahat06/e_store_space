import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/widgets/AlertDialogeWidget.dart';
import 'package:e_store_space/widgets/my_filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/cart/shop_cart_screen_controller.dart';
import 'package:e_store_space/controller/cart_controller.dart';
import 'package:e_store_space/controller/page_controller.dart';
import 'package:e_store_space/models/sub_category_model.dart';
import 'package:e_store_space/settings/color_palates.dart';
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
      body: SingleChildScrollView(
        child: Container(
            width: double.infinity,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return renderingBuyerRequest(index, context);
                }
            )
        ),
      ),
    );
  }

  renderingBuyerRequest(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 10),
      child: Card(
        color: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/image/apple.jpg'),
                  fit: BoxFit.cover,
                )
              ),
            ),
            SizedBox(width: 10.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h,),
                Text('Mobile Phone', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.black),),
                SizedBox(height: 3.h,),
                Text('Product Quantity : 2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.black),),
                SizedBox(height: 3.h,),
                Text('40\$', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.black),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: 45.w,),
                    MyFilledButton(
                      width: 80,
                      height: 30,
                      color: Colors.red,
                      borderRadius: 10,
                      fontSize: 16.sp,
                      txt: "Cancel",
                      ontap: (){},
                    ),
                    SizedBox(width: 15.w,),
                    MyFilledButton(
                      width: 80,
                      height: 30,
                      color: Colors.blue,
                      borderRadius: 10,
                      fontSize: 16.sp,
                      txt: "Accept",
                      ontap: (){},
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
