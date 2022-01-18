import 'package:e_store_space/models/product_category_model.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:get/get.dart';

class ProductCategoryController extends GetxController{
  Rx<ProductCategory> productCategory = ProductCategory().obs;


  @override
  void onInit() {
    loadCategories();
    super.onInit();
  }

  loadCategories() async {
    productCategory.value = await HttpService.getProductCategories();
    print(productCategory);
  }
}