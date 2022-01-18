import 'package:e_store_space/models/product_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:e_store_space/models/product_model.dart';
import 'package:e_store_space/services/http_services.dart';


class ProductController extends GetxController{
  RxInt currentPage = 1.obs;
  RxInt currentSearchPage = 1.obs;
  RxBool search = false.obs;
  RxString isSelectedColors = "0".obs;
  String categoryId;
  int pageNo;
  RxBool progressing = false.obs;
  Rx<ProductDetailsModel> productDetailsModel = ProductDetailsModel().obs;
  ProductController({@required this.categoryId})
  {
    loadProducts(loadMore: false);
  }
  var productsModal = ProductModel(products: []).obs;

  loadProducts({@required bool loadMore}) async {
      progressing.value = true;
      productsModal.value = await HttpService.getProductsOfCategory(categoryId);
      progressing.value = false;
  }

}