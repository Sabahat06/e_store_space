import 'package:e_store_space/models/latest_store_model.dart';
import 'package:e_store_space/models/product_category_model.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:get/get.dart';

class ProductCategoryController extends GetxController{
  Rx<ProductCategory> productCategory = ProductCategory().obs;
  Rx<LatestAndStoreModel> latestAndStoreModel = LatestAndStoreModel().obs;
  @override
  void onInit() {
    loadDeals();
    loadCategories();
    super.onInit();
  }

  loadCategories() async {
    productCategory.value = await HttpService.getProductCategories();
    print(productCategory);
  }

  loadDeals() async {
    latestAndStoreModel.value = await HttpService.getAllStore();
    print('sduhf');
  }
}