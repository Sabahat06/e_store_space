import 'package:e_store_space/controller/order_detail_controller.dart';
import 'package:e_store_space/models/order_detail_model.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/widgets/my_filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_store_space/widgets/my_label.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class OrderDetailScreen extends StatelessWidget {

  OrderDetailModel order;
  OrderDetailScreen(this.order);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: const Text('Order Detail', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: Get.width*0.5, child: const Text("Order Information", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black),)),
                  Container(
                    width: Get.width*0.45,
                    child: Row(
                      children: [
                        const Text("ID: ", style: TextStyle(color: Colors.blue, fontSize: 18),),
                        Text(order.orderDetails.first.id.toString(), style: const TextStyle(fontSize: 18, color: Colors.blue,),),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: Get.width*0.45, child: const Text("Delivery to:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)),
                  Container(width: Get.width*0.45, child: Text(order.orderDetails.first.shapingAddress, style: const TextStyle(fontSize: 18),)),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: Get.width*0.45, child: const Text("Status:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)),
                  Container(width: Get.width*0.45, child: Text(order.orderDetails.first.status, style: const TextStyle(fontSize: 18),)),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: Get.width*0.45, child: const Text("Delivery Date:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)),
                  Container(width: Get.width*0.45, child: Text(order.orderDetails.first.deliveryDate, style: const TextStyle(fontSize: 18),)),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: Get.width*0.45, child: const Text("Delivery Charges:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)),
                  Container(width: Get.width*0.45, child: Text(order.orderDetails.first.deliveryCharge, style: const TextStyle(fontSize: 18),)),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: Get.width*0.45, child: const Text("Total Amount:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)),
                  Container(width: Get.width*0.45, child: Text(order.orderDetails.first.price, style: const TextStyle(fontSize: 18),)),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(width: Get.width*0.45, child: const Text("Products:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)),
                ],
              ),
              order.orderDetails.first.orderProducts ==null || order.orderDetails.first.orderProducts.length == 0
                ? Container()
                : Container(
                    // color: Colors.green,
                    height: order.orderDetails.first.orderProducts.length <= 1 ? Get.height*0.2 :  Get.height*0.4,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: order.orderDetails.first.orderProducts.length,
                      itemBuilder: (context, index) => renderingOrderProduct(order.orderDetails.first.orderProducts[index])
                    ),
                  ),
              const SizedBox(height: 10,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     MyFilledButton(
              //       width: Get.width*0.45,
              //       height: 45,
              //       fontSize: 16,
              //       txt: "Rating",
              //       borderRadius: 6,
              //       color: Colors.blue,
              //     ),
              //     MyFilledButton(
              //       width: Get.width*0.45,
              //       height: 45,
              //       fontSize: 16,
              //       txt: "Re Order",
              //       borderRadius: 6,
              //       color: Colors.blue,
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  renderingOrderProduct(OrderProducts orderProducts){
    return Padding(
      padding: EdgeInsets.all(0),
      child: GestureDetector(
        child: Card(
          elevation: 1,
          child: Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
            ),
            child: Row(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      image: DecorationImage(
                          image: NetworkImage("https://spinningsoft.co/projects/eStoreSpace/admin/images/product/${orderProducts.picture}"),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                const SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(orderProducts.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
                    const SizedBox(height: 5,),
                  ],
                ),
                const SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(orderProducts.pivot.discount, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
                    const SizedBox(height: 5,),
                    Text(orderProducts.pivot.quantity, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
                    const SizedBox(height: 5,),
                    Text(orderProducts.pivot.price, style: const TextStyle(fontSize: 14, color: Colors.black45),),
                    const SizedBox(height: 5,),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
