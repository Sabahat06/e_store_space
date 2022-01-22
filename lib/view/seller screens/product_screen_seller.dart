import 'package:e_store_space/models/product_model.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/view/product/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:e_store_space/controller/product_controller.dart';


class ProductScreenSeller extends StatelessWidget {
  RxString id = '0'.obs;
  String title;
  String categoryId;
  ProductController productController;
  RxList selectedProduct = [].obs;

  ProductScreenSeller({this.categoryId, this.title}){
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
            : ListView.builder(
            itemCount: productController.productsModal.value.products.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return renderingProduct(index, productController.productsModal.value.products[index]);
            }
        ),
      ),
    );
  }

  renderingProduct(int index, Products products) {
    RxInt selectedproductIndex =  productController.productsModal.value.products.indexWhere((element) => element.id==products.id).obs;
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () async {
          selectedProduct.value.add(products.id);
        },
        child: Stack(
          children: [
            Card(
              color: selectedproductIndex.value == index ? Colors.black12 : Colors.transparent,
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
                          rating: double.parse(products.rating),
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
            Positioned(
              top: 7,
              right: 7,
              child: GestureDetector(
                onTap: (){
                  selectedProduct.value.add(products.id);
                },
                child: Container(
                  height: 25,
                  width: 25,
                  color: Colors.blue,
                  child: Center(
                    child: selectedproductIndex.value == index ? Icon(Icons.done_outlined) : Icon(Icons.add),
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