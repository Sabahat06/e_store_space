import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/view/order%20screen/place_order_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartScreenTab extends StatelessWidget {
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 25,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: MyProduct(),
                );
              }
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 7.0.w, left: 3.w, right: 3.w, top: 3.w),
            child: GestureDetector(
              onTap: (){
                Get.to(PlaceOrderLoginScreen());
              },
              child: Container(
                height: 40.h,
                color: Colors.blue,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Text('PLACE ORDER', style: TextStyle(color: Colors.white, fontSize: 18.sp),),
                    ),
                    Row(
                      children: [
                        Text("Rs ", style: TextStyle(color: Colors.white, fontSize: 18.sp),),
                        Text("100", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                        SizedBox(width: 7.w,),
                        Container(width: 2.w, color: Colors.white,),
                        SizedBox(width: 7.w,),
                        Center(
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward_outlined,
                              color: Colors.white,
                            ), iconSize: 30.w,
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
