import 'package:e_store_space/models/product_model.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/view/product/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:e_store_space/controller/product_controller.dart';


class ProductScreen extends StatelessWidget {
  RxString id = '0'.obs;
  String title;
  String categoryId;
  ProductController productController;

  ProductScreen({this.categoryId, this.title}){
    productController =Get.put(ProductController(categoryId: categoryId));
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
            : productController.productsModal.value.products.length == 0 || productController.productsModal.value.products==null
            ? const Center(child: Text('There is No Product in this Category', style: TextStyle(fontSize: 18, color: Colors.black),),)
            : ListView.builder(
            itemCount: productController.productsModal.value.products.length,
            shrinkWrap: true,
            // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     mainAxisSpacing: 1.1
            // ),
            itemBuilder: (BuildContext context, int index) {
              return renderingProduct(index, productController.productsModal.value.products[index]);
            }
        ),
      ),
    );
  }

  renderingProduct(int index, Products products) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () async {
          productController.progressing.value = true;
          productController.productDetailsModel.value = await HttpService.getProductDetails(products.id.toString());
          productController.progressing.value = false;
          Get.to(() => ProductDetailsScreen(productDetailsModel: productController.productDetailsModel.value,));
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
                    Text(products.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
                    const SizedBox(height: 5,),
                    Text(products.price, style: const TextStyle(fontSize: 14, color: Colors.black45),),
                    const SizedBox(height: 5,),
                    SmoothStarRating(
                      color: Colors.purpleAccent,
                      rating: double.parse(products.rating == "" ? "0" : products.rating),
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
  }

}