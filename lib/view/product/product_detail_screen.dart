import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatelessWidget {
  // Products products;
  //
  // ProductDetailsScreen({@required this.products}) {
  //   productDetailsController.totalPrice.value = int.parse(products.salePrice);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: const Text('Product Name', style: TextStyle(color: Colors.white),),
        actions: [
          const Text('Rating', style: TextStyle(fontSize: 16, color: Colors.white),),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 120.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/image/image6.jpg",),
                          fit: BoxFit.contain,
                        )
                      ),
                    ),
                  ],
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 7.0.w, left: 3.w, right: 3.w, top: 3.w),
              child: GestureDetector(
                child: Container(
                  height: 40.h,
                  color: Colors.blue,
                  width: double.infinity,
                  child: const Center(
                    child: Text('Add To Bag', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
