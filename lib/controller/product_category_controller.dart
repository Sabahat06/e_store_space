import 'package:e_store_space/models/latest_store_model.dart';
import 'package:e_store_space/models/product_category_model.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:get/get.dart';

class ProductCategoryController extends GetxController{
  Rx<ProductCategory> productCategory = ProductCategory().obs;
  Rx<LatestAndStoreModel> latestAndStoreModel = LatestAndStoreModel().obs;
  RxBool progressing = false.obs;
  RxBool storeProgressing = false.obs;

  @override
  void onInit() {
    loadDeals();
    loadCategories();
    super.onInit();
  }

  loadCategories() async {
    progressing.value = true;
    productCategory.value = await HttpService.getProductCategories();
    progressing.value = false;
    print(productCategory);
  }

  loadDeals() async {
    storeProgressing.value = true;
    latestAndStoreModel.value = await HttpService.getAllStore();
    storeProgressing.value = false;
    print('sduhf');
  }
}