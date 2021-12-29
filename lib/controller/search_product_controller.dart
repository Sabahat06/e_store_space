import 'package:get/get.dart';
import 'package:e_store_space/models/search.dart';
import 'package:e_store_space/services/http_services.dart';

class SearchProductController extends GetxController{
  RxList<SearchProduct> searchedProducts = <SearchProduct>[].obs;


  loadSearchProduct(String searchString) async {
    searchedProducts.value = await HttpService.searchProduct(searchString);
  }

  clearSearches(){
    searchedProducts.clear();
  }

}