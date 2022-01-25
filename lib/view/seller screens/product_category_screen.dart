import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/product_category_controller.dart';
import 'package:e_store_space/models/product_category_model.dart';
import 'package:e_store_space/view/product/product_screen.dart';
import 'package:e_store_space/view/seller%20screens/product_screen_seller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/settings/color_palates.dart';
import 'package:e_store_space/widgets/my_filled_button.dart';
import 'package:e_store_space/widgets/my_text_field.dart';

class ProductCategoryScreen extends StatelessWidget {
  String storeId;
  bool goToSellerScreen;
  AuthController authController = Get.find();
  ProductCategoryController controller = Get.find();
  List<String> userTypeValue = ['Seller', "Affiliate"];
  ProductCategoryScreen({this.storeId, this.goToSellerScreen});

  RxBool progressing = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: const Text('Products', style: TextStyle(color: Colors.white),),
      ),
      body: Obx(
            () => GridView.builder(
            itemCount: controller.productCategory.value.productCategoryModel.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 1.1
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: MyCategory(context, index, controller.productCategory.value.productCategoryModel[index]),
              );
            }
        ),
      )
    );
  }

  MyCategory(BuildContext context, int index, ProductCategoryModel productCategoryModel){
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        goToSellerScreen
            ? Get.to(() => ProductScreenSeller(categoryId: productCategoryModel.id.toString(), title: productCategoryModel.name,storeId: storeId))
            : Get.to(() => ProductScreen(categoryId: productCategoryModel.id.toString(), title: productCategoryModel.name,));
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          elevation: 2,
          child: Container(
            height: width*0.5,
            // width: width*0.45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[100],
              // border: Border.all(color: Colors.grey),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: const Offset(1, 1), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: width*0.35,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Image.network("https://spinningsoft.co/projects/eStoreSpace/admin/images/product_category/${productCategoryModel.picture}", fit: BoxFit.cover,),
                ),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10,top: 5),
                      child:  Text(productCategoryModel.name,style: const TextStyle(fontWeight: FontWeight.bold),)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
