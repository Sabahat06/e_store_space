import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:e_store_space/models/order_history_model.dart';
import 'package:e_store_space/settings/color_palates.dart';
import 'package:e_store_space/widgets/my_label.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';



class OrderDetailScreen extends StatelessWidget {
  Orders order;
  OrderDetailScreen({this.order});

  @override
  Widget build(BuildContext context) {
    Color labelColor = Colors.black54;
    if(order.status== "Completed")
    {
      labelColor = ColorPalette.green;
    }
    if(order.status== "Pending")
    {
      labelColor = ColorPalette.orange;
    }
    if(order.status== "Cancelled")
    {
      labelColor = Colors.red;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: const Text('Order Details', style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    ...order.orderDetails.map((e) => rendringProduct(e, context)).toList(),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 50,
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyLabel(
                      label: order.status,
                      borderRadius: 5,
                      backGroundColor: labelColor
                    ),
                    Row(
                      children: [
                        const Text('Total : Rs ', style: TextStyle( fontSize: 16),),
                        Text('${int.parse(order.amount)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  rendringProduct(OrderDetails order, BuildContext context){
    return
    Column(
      children: [
        Column(
          children: [
            Container( width: Get.width ,child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                child: Text("${order.productTitle} ${utf8.decode(order.urduTitle.codeUnits)}", style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),))),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                child: Image.network(order.productPhoto)
                              ),
                              Text(order.choiceColorName== "DEFAULT" || order.choiceColorName == null ? "" : order.choiceColorName),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15,),
                      Text("${order.saleQuantity} × ${order.discountedPrice}", style: const TextStyle(fontSize: 16,color: Colors.black54),),
                      const SizedBox(height: 15,),
                      Text('${order.subTotal}',style:TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),)
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5,),
            const Divider(color: Colors.grey,),
          ],
        ),
      ],
    );


//   Column(children: order.dealDetails.map((deal) =>
//
//   ).toList(),);
  }

  // renderingDeal(OrderDetails order, BuildContext context){
  //   return order.dealInformation == null
  //       ? Container()
  //       : SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: GestureDetector(
  //       onTap: (){
  //         Map<String, dynamic> json = order.dealInformation.toJson();
  //         json['deal_details']= order.toJson()['deal_details'];
  //         Get.to(() => DealDetail(deal: Deal.fromJson(json),));
  //       },
  //       child: Container(
  //         height: 150,
  //         color: Colors.white,
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Container(
  //             width: order.dealDetails.length == 1 ? Get.width-20 : Get.width-50,
  //             child: Stack(
  //               alignment: Alignment.topLeft,
  //               children: [
  //                 Card(
  //                     color: ColorPalette.green.shade50,
  //                     child:ListTile(
  //                       title: Column(
  //                         mainAxisSize: MainAxisSize.min,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Text(order.dealInformation.title,style: TextStyle(fontWeight: FontWeight.w800)),
  //                               Text(utf8.decode(order.dealInformation.urduTitle.codeUnits),style: TextStyle(fontWeight: FontWeight.w800)),
  //                             ],
  //                           ),
  //                           SizedBox(height: 10,),
  //                           Text(order.dealInformation.shortDetails,style: TextStyle(fontWeight: FontWeight.w500)),
  //                           SizedBox(height: 10,),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Text("Expires on"),
  //                               Text(order.dealInformation.expiryDate,style: TextStyle(color: ColorPalette.orange)),
  //                             ],
  //                           ),
  //                           SizedBox(height: 10,),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Text("Total price"),
  //                               Row(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 children: [
  //                                   Text("${order.saleQuantity} × ${order.dealInformation.dealAmount} = ",),
  //                                   Text("${(double.parse(order.saleQuantity)* double.parse(order.dealInformation.dealAmount)).toStringAsFixed(0)}",style: TextStyle(fontWeight: FontWeight.bold),),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     )
  //                 ),
  //                 CircleAvatar(
  //                   radius: 10,
  //                   backgroundColor: ColorPalette.green,
  //                   child: Text("${order.saleQuantity}X",style: TextStyle(fontSize: 8,color: Colors.black,fontWeight: FontWeight.bold)),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  //
  // }

  Future<void> _makePhoneCall(String url) async {
    String phoneNumber = 'tel:'+url;
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      // Clipboard.setData(ClipboardData(text: url));
      Fluttertoast.showToast(msg:"Phone number copied");
      throw 'Could not launch $url';
    }
  }

}
