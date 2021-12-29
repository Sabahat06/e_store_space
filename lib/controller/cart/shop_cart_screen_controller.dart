import 'package:cached_map/cached_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:e_store_space/models/cart/new_cart_model.dart';
import 'package:e_store_space/models/product_model.dart';


class CartControllerNew extends GetxController {
  Cart cart = Cart(items:  <Item>[].obs,);

  RxDouble totalAmount = 0.0.obs;
  RxInt totalPrice = 0.obs;
  RxInt amount = 1.obs;
  RxString delivery = '5'.obs;
  var response;
  RxString isSelected = ''.obs;
  RxInt totalItems=0.obs;



  RxString currentChoiceID=''.obs;
  RxString currentChoiceColorName=''.obs;




  Future<Cart> loadCart() async {
    try{
      Map<String, dynamic> cartJson =
      await Mapped.loadFileDirectly(cachedFileName: 'Cart');

      if (cartJson == null) {
        cart.items.value=<Item>[].obs;
      }
      else {
        cart = Cart.fromJson(cartJson);
//        calculateTotalItems();
      }
    }
    catch(e){
      print(e);
    }
  }


  clearCart(){
    Mapped.deleteFileDirectly(cachedFileName: "Cart");
    for (int i = 0; i < cart.items.length; i++) {
      cart.items[i].quantity.value = 0;
    }
    cart.items.clear();
    cart.items.value = [];
  }


 int  calculateTotalItems(){
    int total=0;
    cart.items.forEach((item) {
      total=total+item.quantity.value;
    });
    totalItems.value = total;
    return total;
  }




  addItem(Item item) {
    if(cart.items == null){
      print('items are null $cart.items');
      cart.items.add(item);
    }
    if (cart.items.any((element) => element.choiceID == item.choiceID))
    {
      int index = cart.items.indexWhere((element) => element.id == item.id && element.choiceID == item.choiceID && element.title == item.title);
      if (index != -1) {
        cart.items[index].quantity.value++;
      }
      else{
        cart.items.add(item);
        Fluttertoast.showToast(msg: "Added to bag successfully");
      }
    }
    else {
      cart.items.add(item);
      Fluttertoast.showToast(msg: "Added to bag successfully");
    }
    Mapped.saveFileDirectly(file: Cart(items: cart.items).toJson(), cachedFileName: 'Cart');
    calculateTotalItems();
    print(cart.items);

  }

  removeItem(Item item) {
    int cartIndex = cart.items.indexWhere((element) => element.id == item.id);
    if (cart.items[cartIndex].quantity > 1) {
      cart.items[cartIndex].quantity--;
    } else {
      cart.items[cartIndex].quantity.value--;
      cart.items.removeAt(cartIndex);
      Fluttertoast.showToast(msg: "Item removed");
    }
    Mapped.saveFileDirectly(file: cart.toJson(), cachedFileName: 'Cart');
//    calculateTotalItems();
  }


  double calculateBillingAmount(){
    double price=0;
    cart.items.forEach((element) {
      price+= double.parse(element.discount == "0" ? element.salePrice : element.discountedPrice)*element.quantity.value;
    });
    return price;
  }
}