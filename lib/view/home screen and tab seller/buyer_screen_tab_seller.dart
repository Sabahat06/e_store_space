import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/controller/sold_product_controller.dart';
import 'package:e_store_space/models/sold_product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuyerScreenTabSeller extends StatelessWidget {
  BottomBarController bottomBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    SoldProductController soldProductController = SoldProductController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white, iconSize: 0,),
        leadingWidth: 5,
        title: const Text('Sold Products', style: TextStyle(color: Colors.white),),
      ),
      body: Obx(
        () => soldProductController.progressing.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Container(
              width: double.infinity,
              child: soldProductController.soldProductModel.soldProduct == null || soldProductController.soldProductModel.soldProduct.length == 0
                  ? Center(child: Column(
                    children: [
                      SizedBox(height: 320,),
                      Text('You Have No Sold Products', style: TextStyle(fontSize: 18, color: Colors.black),),
                    ],
                  ),)
                  : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return renderingBuyerRequest(index, context, soldProductController.soldProductModel.soldProduct[index]);
                  }
              )
          ),
        ),
      ),
    );
  }

  renderingBuyerRequest(int index, BuildContext context, SoldProduct product) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 10),
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                  image: DecorationImage(
                      image: NetworkImage("https://spinningsoft.co/projects/eStoreSpace/admin/images/product/${product.picture}"),
                      fit: BoxFit.cover
                  )
              ),
            ),
            SizedBox(width: 20.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3.h,),
                Text(product.name, style: TextStyle(fontSize: 15.sp, color: Colors.black),),
                SizedBox(height: 5.h,),
                Text(product.description, style: TextStyle(fontSize: 15.sp, color: Colors.black),),
                SizedBox(height: 5.h,),
                Text('${product.price}\$', style: TextStyle(fontSize: 15.sp, color: Colors.black),),
              ],
            ),
          ],
        )
      ),
    );
  }
}
