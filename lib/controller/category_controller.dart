import 'package:get/get.dart';
import 'package:e_store_space/models/category_model.dart';
import 'package:e_store_space/services/http_services.dart';


class CategoryController extends GetxController{
  RxInt currentTabIndex = 0.obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxBool progressing = false.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit()  {
   loadCategories();
    super.onInit();
  }
  loadCategories()async{
   await HttpService.getAllCategories().then((cat) {
      categories.addAll(cat);
    });
    isLoading.value = false;
  }
}