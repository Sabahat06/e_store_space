import 'package:e_store_space/models/product_category_model.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:get/get.dart';

class ProductCategoryController extends GetxController{
  ProductCategory productCategory;

  @override
  void onInit() {
    loadCategories();
    super.onInit();
  }

  loadCategories() async {
    productCategory = await HttpService.getProductCategories();
    print(productCategory);
  }
}