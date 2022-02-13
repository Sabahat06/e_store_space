import 'package:cached_map/cached_map.dart';
import 'package:e_store_space/models/product_detail.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:e_store_space/models/cart/new_cart_model.dart';
import 'package:e_store_space/models/product_model.dart';


class CartControllerNew extends GetxController {

  RxList<Item> items = <Item>[].obs;
  RxInt colorCodeid = 0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxInt totalPrice = 0.obs;
  RxInt amount = 1.obs;
  RxString delivery = '5'.obs;
  var response;
  RxString isSelected = ''.obs;
  RxInt totalItems=0.obs;
  RxString currentChoiceID=''.obs;
  RxString currentChoiceColorName=''.obs;


  clearCart(){
    for (int i = 0; i < items.length; i++) {
      items[i].quantity.value = 0;
    }
    items.clear();
    items.value = [];
  }


 int  calculateTotalItems(){
    int total=0;
    items.forEach((item) {
      total=total+item.quantity.value;
    });
    totalItems.value = total;
    return total;
  }




  addItem(Item item) {
    if (items.any((element) => element.choiceID == item.choiceID)) {
      int index = items.indexWhere((element) => element.id == item.id && element.choiceID == item.choiceID);
      if (index != -1) {
        items[index].quantity++;
      }
    }
    else {
      items.add(item);
      Fluttertoast.showToast(msg: "Added to bag successfully");
    }
    // Mapped.saveFileDirectly(file: Cart(items: items).toJson(), cachedFileName: 'Cart');
    calculateTotalItems();
  }

  removeItem(Item item) {
    int cartIndex = items.indexWhere((element) => element.id == item.id && element.choiceID == item.choiceID);
    if (items[cartIndex].quantity.value > 1) {
      items[cartIndex].quantity.value--;
    } else {
      items[cartIndex].quantity.value--;
      items.removeAt(cartIndex);
      Fluttertoast.showToast(msg: "Item removed");
    }
    // Mapped.saveFileDirectly(file: cart.toJson(), cachedFileName: 'Cart');
   calculateTotalItems();
  }


  double calculateBillingAmount(){
    double price=0;
    items.forEach((element) {
      price+= double.parse(element.price)*element.quantity.value;
    });
    return price;
  }
}