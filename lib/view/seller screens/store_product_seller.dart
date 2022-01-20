import 'package:e_store_space/view/product/product_detail_screen.dart';
import 'package:e_store_space/view/seller%20screens/adding_product.dart';
import 'package:e_store_space/view/seller%20screens/product_category_screen.dart';
import 'package:e_store_space/view/seller%20screens/product_detail_seller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StoreProductsSeller extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: const Text('Store Name', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: GridView.builder(
                itemCount: 7,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.1
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: MyProduct(index),
                  );
                }
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
          Get.to(() => ProductCategoryScreen());
        },
        child: Container(
          height: 40.h,
          width: 150.w,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Text(
              'Add Product',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }

  MyProduct(int index){
    return Padding(
      padding: EdgeInsets.all(10.0.w),
      child: GestureDetector(
        onTap: (){Get.to(() => ProductDetailSellerScreen());},
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: index%2==0 ? AssetImage( "assets/image/apple.jpg",) :  AssetImage( "assets/image/shoes.jpg",),
                      fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: Colors.blue,width: 2),
                  color: Colors.lightGreen
              ),
              height: 225.h,
              width: 180.w,
            ),
            Container(
              height: 45.h,
              width: 190.w,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15.r),
                    bottomLeft: Radius.circular(15.r)
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left:7.0.w, right: 7.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h,),
                        Text('Product Name', style: TextStyle(color: Colors.white),),
                        Text('Price', style: TextStyle(color: Colors.white),),
                      ],
                    ),
                    const Text('Rating', style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
