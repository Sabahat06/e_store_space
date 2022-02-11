import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/controller/wish_list_controller.dart';
import 'package:e_store_space/models/product_detail.dart';
import 'package:e_store_space/widgets/AlertDialogeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FavoriteScreenTab extends StatelessWidget {
  BottomBarController bottomBarController = Get.find();
  WishListController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white, iconSize: 0,),
        leadingWidth: 5,
        title: const Text('Favorite', style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => controller.items.length==0
                  ? const Center(child: Text("Your WishList is Empty", style: TextStyle(fontSize: 18),),)
                  : ListView.builder(
                  itemCount: controller.items.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: MyProduct(controller.items[index], context),
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }

  MyProduct(ProductDetailsModel product, BuildContext context){
    return Padding(
      padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w, top: 8.0.w, bottom: 8.0.w),
      child: Card(
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0.r),
            color: Colors.white,
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
                        child: Image.network("https://spinningsoft.co/projects/eStoreSpace/admin/images/product/${product.productDetails.picture}")
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(product.productDetails.name, style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),),
                        SizedBox(height: 5.h,),
                        Text(product.productDetails.price, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.blue),),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        controller.items.any((element) => element.productDetails.id==product.productDetails.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                        size: 30,
                      ),
                      onPressed: (){
                        // controller.addOrRemoveItem(product);
                      },
                    ),
                    IconButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialogWidget(
                                title: 'Remove Alert',
                                subTitle: "Are you sure to Remove from WishList?",
                                onPositiveClick: () {
                                  controller.addOrRemoveItem(product);
                                  Get.back();
                                },
                              );
                            }
                        );
                      },
                      icon: const Icon(Icons.delete_outlined, color: Colors.red,) ,
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
      ),
    );
  }
}
