import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:e_store_space/models/product_model.dart';
import 'package:e_store_space/services/http_services.dart';


class ProductController extends GetxController{
  RxInt currentPage = 1.obs;
  RxInt currentSearchPage = 1.obs;
  RxBool search = false.obs;
  RxString isSelectedColors = "0".obs;
  String subCategoryID;
  int pageNo;
  RxBool progressing = false.obs;
  ProductController({@required this.subCategoryID,@required this.pageNo})
  {
    loadProducts(loadMore: false);
  }
  var productsModal = ProductModel(products: [],totalPages: 0).obs;

  loadProducts({@required bool loadMore}) async {
    if(!loadMore)
    {
      currentPage = 1.obs;
      progressing.value = true;
      productsModal.value = await HttpService.getProductsOfSubCategory(subCategoryID, currentPage.value);
      progressing.value = false;
    }
    else
    {
      currentPage.value++;
      ProductModel productResult = await HttpService.getProductsOfSubCategory(subCategoryID, currentPage.value);
      productsModal.value.products.addAll(productResult.products);
      update();
      print("added");
    }
    // progressing.value = true;
    // productsModal.value = await HttpService.getProductsOfSubCategory(subCategoryID, pageNo);
    // progressing.value = false;
  }
  // loadMoreProducts(String subCategoryID,int pageNo) async {
  //   ProductModel rawModal = await  HttpService.getProductsOfSubCategory(subCategoryID, pageNo);
  //   productsModal.value.products.addAll(rawModal.products);
  // }

}