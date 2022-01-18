import 'package:e_store_space/models/product_detail.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:get/get.dart';

import 'package:e_store_space/models/cart_model.dart';
import 'package:e_store_space/models/product_model.dart';
import 'package:cached_map/cached_map.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetailsController extends GetxController {
  RxBool progressing = false.obs;
  Rx<ProductDetailsModel> productDetailsModel = ProductDetailsModel().obs;

  ProductDetailsController({String productId}){
    loadProduct(productId);
  }

  loadProduct(String id) async {
    progressing.value =true;
    productDetailsModel.value = await HttpService.getProductDetails(id);
    progressing.value =false;
  }
}