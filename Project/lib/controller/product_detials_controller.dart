import 'package:get/get.dart';

import 'package:e_store_space/models/cart_model.dart';
import 'package:e_store_space/models/product_model.dart';
import 'package:cached_map/cached_map.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartController extends GetxController {


  RxInt totalPrice=0.obs;
  RxInt amount=0.obs;
  RxInt cartIndex = 1.obs;

  Cart cart = Cart(products: <Products>[].obs,);
  RxInt totalItems = 0.obs;
  RxBool progressing = false.obs;

  addItem(Products product,int index) {
    if (index != -1) {
      cart.products[index].quantity.value++;
    }
    else {
      product.quantity.value = 1;
      cart.products.add(product);
      cartIndex.value = 1;
    }

    Mapped.saveFileDirectly(file: cart.toJson(), cachedFileName: 'Cart');
//    if(index ==-1)
//      FlutterToast.showToast(message: "Added to cart successfully",);
//      calculateTotalItems();
  }

  removeItem(Products product,int index) {
    if(cart.products[index].quantity.value>1) {
      cart.products[index].quantity.value--;
    }
    else
    {
      cart.products.removeAt(index);
//      Utils.showToast("Item removed");
    }
    Mapped.saveFileDirectly(
        file: cart.toJson(), cachedFileName: 'Cart');
//    calculateTotalItems();
  }

}