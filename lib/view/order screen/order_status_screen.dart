import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/order_status_screen_controller.dart';
import 'package:e_store_space/models/order_history_model.dart';
import 'package:e_store_space/settings/color_palates.dart';
import 'package:e_store_space/view/account_screens/order_histroy_screen.dart';
import 'package:e_store_space/widgets/AlertDialogeWidget.dart';
import 'package:e_store_space/widgets/my_filled_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'order_details.dart';


class OrderStatusScreen extends StatelessWidget {
  Orders order;
  OrderStatusScreen({this.order});
  OrderStatusScreenController controller = OrderStatusScreenController();
  List<String> statusList = ['Pending','Verified','Completed'];

  @override
  Widget build(BuildContext context) {
    if(order.status=="Cancelled"&& !statusList.any((element) => element=="Cancelled"))
    {
      statusList.add("Cancelled");
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: const Text('Order Status', style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
              ()=> ModalProgressHUD(
            inAsyncCall: controller.progressing.value,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Order #:${order.id}"),
                          order.status == "Pending"?
                          MyFilledButton(
                            txt: "Cancel",
                            color: ColorPalette.orange,
                            borderRadius: 5,
                            width: 100,
                            height: 30,
                            ontap: (){
                              showDialog(context: context, builder: (BuildContext context){
                                return  AlertDialogWidget(title: "Cancel Alert",
                                  subTitle: "Are you sure to cancel this order?",
                                  onPositiveClick: () async {
                                    Get.back();
                                    String status =  await  controller.cancelOrder(order.id);
                                    if(status=="success")
                                    {
                                      order.status="Cancelled";
                                      statusList.add("Cancelled");
                                      controller.progressing.value = false;
                                      Get.off(OrderHistoryScreen());
                                    }
                                  },
                                );
                              });

                            },
                          ):
                          Container()
                        ],
                      ),
                      Divider(),
                      // Stepper(steps: statusList.map((status){
                      //   return Step(
                      //       title: Text(status),
                      //       content: Container(child: Text("Test"),),
                      //     state:   StepState.indexed,
                      //     isActive: statusIndex("Processed")>= statusIndex(status)
                      //   );
                      // }).toList(),
                      // // currentStep: statusIndex(order.status),
                      // )

                      ...statusList.map((status) {
                        // order.status = "Cancelled";
                        if(order.status=="Cancelled")
                        {
                          return StepperRow(status=="Cancelled",status);
                        }
                        else
                          return  StepperRow(statusIndex(order.status)>= statusIndex(status),status);
                      }
                      ).toList(),
                      const SizedBox(height: 20,),
                      const Divider(thickness: 5,),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          const Text("Order Date: "),
                          Text(order.createdDate,style: const TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),
                      // const SizedBox(height: 10,),
                      // Row(
                      //   children: const [
                      //     Text("Payment Mode: "),
                      //     Text("COD",style: TextStyle(fontWeight: FontWeight.bold),)
                      //   ],
                      // ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const Text("Delivery Time Slot: "),
                          Text("${order.timeFrom} - ${order.timeTo}",style: const TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const Text("Delivery Date: "),
                          Text(order.deliveryDate,style: const TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),

                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const  Text("Delivery Charges: "),
                           Text(order.deliveryStatus == '0'? 'To be Calculated': order.productDelivery == '0'? 'Free':'Rs. '+order.productDelivery.toString(),style: const TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const Text("Total Price: "),
                          Text('Rs. '+order.amount,style: const TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: MyFilledButton(
                    txt:"View Order Details",
                    color: ColorPalette.orange,
                    width: Get.width-16,
                    borderRadius: 12,
                    ontap: (){
                      Get.to(OrderDetailScreen(order: order,));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  Widget StepperRow(bool active,String status){
    Color dotColor = ColorPalette.green;
    String date = "";
    if(status==statusList[0])
    {
      date = order.createdDate??"";
    }
    else if(status == statusList[1])
    {
      date = order.verifiedDate??"";
    }
    // else if(status == statusList[2])
    // {
    //   date = order.processedDate??"";
    // }
    // else if(status == statusList[3])
    // {
    //   date = order.assignedDate??"";
    // }
    else if(status == statusList[2])
    {
      date = order.paidDate??"";
    }
    else if(status == statusList[3])
    {
      date = order.cancelledDate??"";
      dotColor = Colors.red;
    }

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Container(
                width: 2,
                height: 30,
                color: Colors.grey,
              ),
            ),
            Row(mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle,color: active?dotColor:Colors.grey,size: 15,),
                Container(
                    width: 100,
                    child: Text(" "+status)),
                SizedBox(width: 50,),
                Text(date),
              ],
            )
          ],
        ),

      ],
    );

  }

  int statusIndex(String status){
    return statusList.indexOf(status);
  }

}
