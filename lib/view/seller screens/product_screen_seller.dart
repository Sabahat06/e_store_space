import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/models/place_order_detail_modal.dart';
import 'package:e_store_space/models/product_detail.dart';
import 'package:e_store_space/models/product_model.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/statics/static_var.dart';
import 'package:e_store_space/view/home%20screen%20and%20tab%20seller/home_screen_tab_seller.dart';
import 'package:e_store_space/view/homepage.dart';
import 'package:e_store_space/view/product/product_detail_screen.dart';
import 'package:e_store_space/view/product/review_screen.dart';
import 'package:e_store_space/widgets/my_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:e_store_space/controller/product_controller.dart';


class ProductScreenSeller extends StatelessWidget {
  AuthController authController = Get.find();
  RxString id = '0'.obs;
  String title;
  String storeId;
  String categoryId;
  ProductController productController;
  List selectedProduct = [];

  ProductScreenSeller({this.categoryId, this.title, this.storeId}){
    productController = Get.put(ProductController(categoryId: categoryId));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: Text(title, style: const TextStyle(color: Colors.white),),
      ),
      body: Obx(
        () => productController.progressing.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
              children: [
                productController.productsModal.value.products == null || productController.productsModal.value.products.length == 0
                    ? Expanded(child: Center(child: Text('There is No Product in this Category', style: TextStyle(fontSize: 16.sp, color: Colors.black),),))
                    : Expanded(
                  child: ListView.builder(
                  itemCount: productController.productsModal.value.products.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return renderingProduct(index, productController.productsModal.value.products[index]);
                  }
        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyFilledButton(
                    color: Colors.blue,
                    height: 45,
                    txt: 'Add to Store',
                    width: double.infinity,
                    borderRadius: 0,
                    ontap: () async {
                      List<SelectedProductSeller> selectedProductSeller = [];
                      if(selectedProduct.length==0){
                        Fluttertoast.showToast(msg: "Select Some Products");
                      }else {
                        selectedProduct.forEach((product) {
                          selectedProductSeller.add(SelectedProductSeller(product_id: product.toString(),));
                        });
                        productController.progressing.value = true;
                        for(int i=0;i<=selectedProductSeller.length;i++){
                          var response = await HttpService.addStoreProduct(
                            i: i,
                            product_id: selectedProductSeller[i].product_id,
                            token: authController.user.value.token,
                            store_id: storeId,
                            user_id:  authController.user.value.user.id.toString()
                          );
                        }
                        productController.progressing.value = false;
                        if(StaticVariable.addStoreProductResponseCode == 200 || StaticVariable.addStoreProductResponseCode == 201){
                          Fluttertoast.showToast(msg: "Your Products Added Successfully");
                          Get.off(() => HomePage());
                        }
                      }

                    },
                  ),
                )
              ],
            ),
      ),
    );
  }

  renderingProduct(int index, Products products) {
    // String rating = double.parse(products.rating).toStringAsFixed(1)??"0";
    return GestureDetector(
      onTap: () async {
        productController.progressing.value = true;
        ProductDetailsModel productDetailsModel = await HttpService.getProductDetails(products.id.toString());
        productController.progressing.value = false;
        Get.to(() => ReviewsScreen(ratings: productDetailsModel.productDetails.ratings,));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Obx(
              () => Card(
                color: products.isSelected.value? Colors.blue : Colors.white,
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
                                image: NetworkImage("https://spinningsoft.co/projects/eStoreSpace/admin/images/product/${products.picture}"),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5,),
                          Text(products.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
                          const SizedBox(height: 5,),
                          Text(products.price, style: const TextStyle(fontSize: 14, color: Colors.black45),),
                          const SizedBox(height: 5,),
                          SmoothStarRating(
                            color: Colors.purpleAccent,
                            rating: double.parse(products.rating=="" || products.rating == null ? "0" : products.rating),
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
            Positioned(
              top: 2,
              right: 2,
              child: InkWell(
                onTap: (){
                  if(products.isSelected.value == false){
                    selectedProduct.add(products.id);
                    products.isSelected.value = true;
                  }
                  else{
                    selectedProduct.remove(products.id);
                    products.isSelected.value = false;
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
                    color: Colors.blue,
                  ),
                  height: 30,
                  width: 30,
                  child: Obx(
                    () => Center(
                      child: products.isSelected.value
                          ? Icon(Icons.done_outlined, color: Colors.white,)
                          : Icon(Icons.add, color: Colors.white,),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}