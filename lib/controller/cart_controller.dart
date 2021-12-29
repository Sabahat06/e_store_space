// import 'package:cached_map/cached_map.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:yousafmobile/models/cart_model.dart';
// import 'package:yousafmobile/models/product_model.dart';
//
//
// class CartController extends GetxController {
//   Cart cart = Cart(products: <Products>[].obs,);
//
//   RxDouble totalAmount = 0.0.obs;
//   RxInt totalPrice = 0.obs;
//   RxInt amount = 1.obs;
//   RxString delivery = '5'.obs;
//   var response;
//   RxString isSelected = ''.obs;
//
//   RxString dynamicColorId=''.obs;
//   RxString dynamicColorCode=''.obs;
//
//
//
//   Future<Cart> loadCart() async {
//     // var response=    HttpService.getAppSetting();
//     // deliveryCharges.value=response['product_delivery'].toString();
//     try{
//       Map<String, dynamic> cartJson =
//       await Mapped.loadFileDirectly(cachedFileName: 'Cart');
//
//       if (cartJson == null) {
//         cart.products.value=<Products>[].obs;
//       }
//       else {
//         cart = Cart.fromJson(cartJson);
// //        calculateTotalItems();
//       }
//     }
//     catch(e){
//       print(e);
//     }
//   }
//
//
//   clearCart(){
//     Mapped.deleteFileDirectly(cachedFileName: "Cart");
//     for (int i = 0; i < cart.products.length; i++) {
//       cart.products[i].quantity.value = 0;
//     }
//     cart.products.clear();
//     // cart.products.value = [];
//   }
//
//   ///adding/incrementing item or deal to cart///////////////////////////////////////////////////////////////////////
//   int productInsertionIndex=0;
//   addItem(Products product, int index, int productQuantity, String selectedColor, String colorCode) {
//     int colorIndex = cart.products.indexWhere((element) => element.id == product.id && product.colorId.value == selectedColor);
//     int productIndex =cart.products.indexWhere((element) => element.id == product.id);
//
//
//     if(colorIndex != -1){
//       cart.products[colorIndex].quantity.value ++;
//     }
//     else if(productIndex  != -1){   // product id recievde color not recived
//       cart.products.add(product);
//     }
//     else{
//       cart.products.add(product);
//     }
//
//     print(cart.products);
//     print(cart.products);
//
//
//
//     // if (productIndex > -1 && colorIndex > -1) {
//     //   // isSelected.value = colorIndex.toString();
//     //
//     //   allCartItems.add(product);
//     //
//     //   cart.products[productIndex].quantity.value++;
//     //   Fluttertoast.showToast(msg: "product & color ids exist");
//     // }else if(productIndex > -1 && colorIndex < 0){
//     //
//     //   product.quantity.value = 1;
//     //   product.colorId.value = selectedColor;
//     //   product.colorCode.value = colorCode;
//     //   cart.products.insert(productInsertionIndex, product);
//     //   productInsertionIndex++;
//     //
//     //   allCartItems.add(product);
//     //
//     //   // cart.products.add(product);
//     //
//     //   Fluttertoast.showToast(msg: "product exists & color doesn't exist");
//     //
//     // }else {
//     //   product.quantity.value = 1;
//     //   product.colorId.value = selectedColor;
//     //   product.colorCode.value = colorCode;
//     //
//     //   cart.products.insert(productInsertionIndex, product);
//     //   productInsertionIndex++;
//     //   // cart.products.add(product);
//     //   Fluttertoast.showToast(msg: "nothing exist!");
//     // }
//
//     // cart.products.insert(1, product);
//
//     print('printing prducts${cart.products}');
//     print('printing prducts${cart.products}');
//
//
//
//     // if(cart.products.where((element) => element.id==product.id) == product.id && product.colorId.value == selectedColor){
//     //   isSelected.value = cartIndex.toString();
//     //   cart.products[cartIndex].quantity.value++;
//     // }
//     // else {
//     //   product.quantity.value = 1;
//     //   product.colorId.value = selectedColor;
//     //   product.colorCode.value = colorCode;
//     //   cart.products.add(product);
//     //   Fluttertoast.showToast(msg: 'Added to cart successfully');
//     // }
//
//
//     Mapped.saveFileDirectly(file: cart.toJson(), cachedFileName: 'Cart');
// //      calculateTotalItems();
//   }
//
// //   addItem(Products product,int index, int productQuantity, String selectedColor, String colorCode) {
// //     int cartIndex = cart.products.indexWhere((element) => element.id==product.id && product.colorId.value == selectedColor);
// //     if(cart.products.indexWhere((element) => element.colorId.value == selectedColor) != -1){
// //       if (cartIndex!=-1) {
// //         isSelected.value = cartIndex.toString();
// //         cart.products[cartIndex].quantity.value++;
// //       }
// //       // else{
// //       //   product.quantity.value = 1;
// //       //   product.colorId.value = selectedColor;
// //       //   product.colorCode.value = colorCode;
// //       //   cart.products.add(product);
// //       //   Fluttertoast.showToast(msg: 'Added to cart successfully');
// //       // }
// //     }else {
// //       print(cart.products);
// //       product.quantity.value = productQuantity;
// //       product.colorId.value = selectedColor;
// //       product.colorCode.value = colorCode;
// //       cart.products.add(product);
// //       Fluttertoast.showToast(msg: 'Added to cart successfully');
// //     }
// //     Mapped.saveFileDirectly(file: cart.toJson(), cachedFileName: 'Cart');
// // //      calculateTotalItems();
// //   }
//   ///removing/decrementing item or deal to cart///////////////////////////////////////////////////////////////////////
//
//   removeItem(Products product, int index) {
//     int cartIndex =
//         cart.products.indexWhere((element) => element.id == product.id);
//     if (cart.products[cartIndex].quantity.value > 1) {
//       cart.products[cartIndex].quantity.value--;
//     } else {
//       cart.products[cartIndex].quantity.value--;
//       cart.products.removeAt(cartIndex);
//       Fluttertoast.showToast(msg: "Item removed");
//     }
//     Mapped.saveFileDirectly(file: cart.toJson(), cachedFileName: 'Cart');
// //    calculateTotalItems();
//   }
//
//   ///removing item (all quantities)  or deal to cart///////////////////////////////////////////////////////////////////////
//
//
//   removeFullItem(Products product,int index) {
//     cart.products.removeAt(index);
//     Fluttertoast.showToast(msg: "Item removed");
//
//     Mapped.saveFileDirectly(
//         file: cart.toJson(), cachedFileName: 'Cart');
//   }
//
//
//   // double calculateTotalAmmout(){
//   //   // double dealTotal =  calculateDealsTotalAmount();
//   //   double productTotal = calculateProductsTotalAmount();
//   //   return dealTotal + productTotal;
//   // }
// //
//   double calculateProductsTotalAmount(double quantity,double saleprice){
//     double price=0.0;
//     price= quantity * saleprice;
//     totalAmount=totalAmount+price;
//
//     return price;
//   }
//
//
//   double calculateBillingAmount(){
//     double price=0;
//     cart.products.forEach((element) {
//       price+= double.parse(element.salePrice)*element.quantity.value;
//     });
//     return price;
//   }
//
//
// //
// //  double calculateDealsTotalAmount(){
// //    double price=0;
// //    cart.deals.forEach((element) {
// //      price+= double.parse(element.dealAmount)*element.quantity.value;
// //    });
// //    return price;
// //  }
// //
// //
//
// }