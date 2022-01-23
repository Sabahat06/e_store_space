import 'package:e_store_space/controller/product_controller.dart';
import 'package:e_store_space/models/get_store_product.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/view/product/product_detail_screen.dart';
import 'package:e_store_space/view/seller%20screens/adding_product.dart';
import 'package:e_store_space/view/seller%20screens/product_category_screen.dart';
import 'package:e_store_space/view/seller%20screens/product_detail_seller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class StoreProductsSeller extends StatelessWidget {
  // ProductController productController = Get.find();
  StoreProductModel storeProductModel;
  String title;
  String storeId;

  StoreProductsSeller(this.storeProductModel, this.title, this.storeId);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: Text(title, style: TextStyle(color: Colors.white),),
      ),
      body: storeProductModel.storeProduct == null || storeProductModel.storeProduct.length == 0
          ? Center(child: Text('You have No Product in this Store'),)
          : Padding(
        padding: EdgeInsets.all(10.w),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: ListView.builder(
                itemCount: storeProductModel.storeProduct.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: MyProduct(index, storeProductModel.storeProduct[index]),
                  );
                }
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
          Get.to(() => ProductCategoryScreen(storeId: storeId, goToSellerScreen: true,));
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

  MyProduct(int index, StoreProduct product){
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () async {
          // productController.progressing.value = true;
          // productController.productDetailsModel.value = await HttpService.getProductDetails("1");
          // productController.progressing.value = false;
          // Get.to(() => ProductDetailsScreen(productDetailsModel: productController.productDetailsModel.value,));
        },
        child: Card(
          elevation: 1,
          child: Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
            ),
            child: Row(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      image: DecorationImage(
                          image: NetworkImage("https://spinningsoft.co/projects/eStoreSpace/admin/images/product/${product.picture}"),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                const SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(product.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
                    const SizedBox(height: 5,),
                    Text(product.price, style: const TextStyle(fontSize: 14, color: Colors.black45),),
                    const SizedBox(height: 5,),
                    SmoothStarRating(
                      color: Colors.purpleAccent,
                      rating: double.parse(product.ratingsAverage),
                      size: 18,
                      isReadOnly: true,
                      borderColor: Colors.purpleAccent,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // return Padding(
    //   padding: EdgeInsets.all(10.0.w),
    //   child: GestureDetector(
    //     onTap: (){Get.to(() => ProductDetailSellerScreen());},
    //     child: Stack(
    //       alignment: Alignment.bottomCenter,
    //       children: [
    //         Container(
    //           decoration: BoxDecoration(
    //               image: DecorationImage(
    //                   image: index%2==0 ? AssetImage( "assets/image/apple.jpg",) :  AssetImage( "assets/image/shoes.jpg",),
    //                   fit: BoxFit.cover
    //               ),
    //               borderRadius: BorderRadius.circular(15.r),
    //               border: Border.all(color: Colors.blue,width: 2),
    //               color: Colors.lightGreen
    //           ),
    //           height: 225.h,
    //           width: 180.w,
    //         ),
    //         Container(
    //           height: 45.h,
    //           width: 190.w,
    //           decoration: BoxDecoration(
    //             color: Colors.black54,
    //             borderRadius: BorderRadius.only(
    //                 bottomRight: Radius.circular(15.r),
    //                 bottomLeft: Radius.circular(15.r)
    //             ),
    //           ),
    //           child: Padding(
    //             padding: EdgeInsets.only(left:7.0.w, right: 7.0.w),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     SizedBox(height: 10.h,),
    //                     Text('Product Name', style: TextStyle(color: Colors.white),),
    //                     Text('Price', style: TextStyle(color: Colors.white),),
    //                   ],
    //                 ),
    //                 const Text('Rating', style: TextStyle(color: Colors.white),),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

}
