import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/cart/shop_cart_screen_controller.dart';
import 'package:e_store_space/controller/cart_controller.dart';
import 'package:e_store_space/models/cart/new_cart_model.dart';
import 'package:e_store_space/models/product_model.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/statics/static_var.dart';
import 'package:e_store_space/view/auth%20screen/create_account.dart';
import 'package:e_store_space/view/order%20screen/place_order_login.dart';
import 'dart:io' show Platform;

class CartScreen extends StatelessWidget {
  CartScreen({Key key}) : super(key: key);
  CartControllerNew cartController= Get.find();
  AuthController authController = Get.find();

  // Products products;

  @override
  Widget build(BuildContext context) {
    // HttpService.getAppSettings();
    var width= Get.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: const Text('Cart Items', style: TextStyle(color: Colors.black),),

      ),
      body: Obx(
            ()=>  cartController.cart.items.length ==0   ? const Center(child: Text('There are no items in your Cart !'),) :
        Column(
          children: [
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: cartController.cart.items.length,
                  itemBuilder: (BuildContext context,int index){
                    return renderItem(width,index,cartController.cart.items[index]);
                  }
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: (){
                  Get.to(() => authController.isLogedIn.value
                    ? PlaceOrderLoginScreen(cartController.calculateBillingAmount().toStringAsFixed(0)) // static value initially
                    : CreateAccount(true));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange,
                  ),
                  height: 45,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('PLACE ORDER', style: TextStyle(color: Colors.white, fontSize: 20),),
                      ),
                      Row(
                        children: [
                          Text("Rs ${cartController.calculateBillingAmount().toStringAsFixed(0)}",style: const TextStyle(color: Colors.white,fontSize: 20),),
                          const SizedBox(width: 7,),
                          Container(width: 2, color: Colors.black54,),
                          const SizedBox(width: 7,),
                          const Center(
                              child: IconButton(
                                icon: Icon(Icons.arrow_forward_outlined,
                                  color: Colors.white,
                                ), iconSize: 30,
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Platform.isIOS ? const SizedBox(height: 15,): Container()
          ],
        ),
      ),
    );
  }

  Widget renderItem( double width, int index, Item item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: width,),
          Container(
            width: double.infinity,
            child: Obx(
                  ()=> Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.title, style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                            child: Image.network(cartController.cart.items[index].photo,width: 90,height: 100,),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(3.0),
                              child:Text(item.choiceColorName.toString()),
                              // Container(
                              //   height: 20,
                              //   width: 20,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(50),
                              //     color: Color(int.parse(item.choiceColorCode)),
                              //   ),
                              // )
                            //
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                Text('${item.quantity}'+'x'),
                                Text(item.discount == "0" ? '${item.salePrice}' : '${item.discountedPrice}'),
                              ],
                            ),
                            const SizedBox(height: 5),
                            item.discount == "0"
                                ? Text('${(item.quantity *double.parse(item.salePrice)).toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold),)
                                : Text('${(item.quantity *double.parse(item.discountedPrice)).toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold),),
                            const SizedBox(height: 5,),
                            Container(
                              height: 27,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        cartController.removeItem(item);
                                        if(item.quantity>0){
                                          cartController.totalPrice.value= cartController.totalPrice.value-int.parse(item.salePrice);
                                        };
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white),
                                        child: const Icon(Icons.remove, size: 20),
                                      ),
                                    ),
                                    const SizedBox(width: 7,),
                                    Text("${item.quantity}", style: const TextStyle(fontSize: 13, color: Colors.white), ),
                                    const SizedBox(width: 7,),
                                    GestureDetector(
                                      onTap: (){
                                        cartController.addItem(item);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1,color: Colors.black,)
        ],
      ),
    );
  }
}
