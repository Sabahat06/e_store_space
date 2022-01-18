import 'package:cached_map/cached_map.dart';
import 'package:e_store_space/models/product_detail.dart';
import 'package:e_store_space/models/wish_list_modal.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {
  WishList wishList = WishList(items: []);

  RxList<ProductDetailsModel> items = <ProductDetailsModel>[].obs;



  @override
  onInit()  {
    loadList();
    super.onInit();
  }

  Future<WishList> loadList() async {
    try{
      Map<String, dynamic> wishList =
      await Mapped.loadFileDirectly(cachedFileName: 'WishList');

      if (wishList == null)
        items.value=[];
      else
        items.value = WishList.fromJson(wishList).items;
    }
    catch(e){
      print(e);
    }
  }


  addOrRemoveItem(ProductDetailsModel product) {
    if (items.any((element) =>
    element.productDetails.id == product.productDetails.id)) {
      removeItem(product);
    }

    else{
      items.add(product);
      Mapped.saveFileDirectly(file: WishList(items: items).toJson(), cachedFileName: 'WishList');
      Fluttertoast.showToast(msg: "Added to wish list");
    }
  }

  removeItem(ProductDetailsModel product) {
    int index = items.indexWhere((element) =>
    element.productDetails.id == product.productDetails.id );
    if (index != null) {
      items.removeAt(index);
      Mapped.saveFileDirectly(
          file: WishList(items: items).toJson(), cachedFileName: 'WishList');
      Fluttertoast.showToast(msg: "Item removed from wish list");
    } else
      print("index not found");
  }
}
