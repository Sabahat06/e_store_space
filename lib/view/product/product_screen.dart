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
            : GridView.builder(
            itemCount: productController.productsModal.value.products.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 1.1
            ),
            itemBuilder: (BuildContext context, int index) {
              return renderingProduct(index, productController.productsModal.value.products[index]);
            }
        ),
      ),
    );
  }

  renderingProduct(int index, Products products) {
    return Padding(
      padding: EdgeInsets.all(10.0.w),
      child: GestureDetector(
        onTap: () async {
          productController.progressing.value = true;
          productController.productDetailsModel.value = await HttpService.getProductDetails(products.id.toString());
          productController.progressing.value = false;
          Get.to(() => ProductDetailsScreen(productDetailsModel: productController.productDetailsModel.value,));
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("https://spinningsoft.co/projects/eStoreSpace/admin/images/product/${products.picture}"),
                      fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.blue,width: 2),
                  color: Colors.lightGreen
              ),
              height: 230.h,
              width: 190.w,
            ),
            Container(
              height: 45.h,
              width: 190.w,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.r),
                    bottomLeft: Radius.circular(10.r)
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left:15.0.w, right: 10.0.w),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SmoothStarRating(
                              color: Colors.yellow,
                              rating: double.parse(products.rating),
                              size: 15,
                              isReadOnly: true,
                              borderColor: Colors.yellow,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(

                          children: [
                            Text(products.name, style: const TextStyle(color: Colors.white, fontSize: 15),),
                            const SizedBox(width: 50,),
                            Text(products.price, style: const TextStyle(color: Colors.white, fontSize: 15),),
                          ],
                        ),
                      ],
                    ),
                    // Text(double.parse(products.rating).toStringAsFixed(1), style: TextStyle(color: Colors.white),),
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