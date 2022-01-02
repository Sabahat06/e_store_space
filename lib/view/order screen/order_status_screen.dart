import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    // if(order.status=="Cancelled"&& !statusList.any((element) => element=="Cancelled"))
    // {
    //   statusList.add("Cancelled");
    // }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: const Text('Order Status', style: TextStyle(color: Colors.white),),
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
                          Text("Order # 1"),
                          // order.status == "Pending"?
                          MyFilledButton(
                            txt: "Cancel",
                            color: Colors.blue,
                            borderRadius: 5,
                            width: 100.w,
                            height: 30.h,
                            ontap: (){
                              showDialog(context: context, builder: (BuildContext context){
                                return  AlertDialogWidget(title: "Cancel Alert",
                                  subTitle: "Are you sure to cancel this order?",
                                  onPositiveClick: () async {
                                    Get.back();
                                    // String status =  await  controller.cancelOrder(order.id);
                                    // if(status=="success")
                                    // {
                                    //   order.status="Cancelled";
                                    //   statusList.add("Cancelled");
                                    //   controller.progressing.value = false;
                                    //   Get.off(OrderHistoryScreen());
                                    // }
                                  },
                                );
                              });

                            },
                          )
                          // Container()
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
                        // // order.status = "Cancelled";
                        // if(order.status=="Cancelled")
                        // {
                        //   return StepperRow(status=="Cancelled",status);
                        // }
                        // else
                          return  StepperRow(status);
                      }
                      ).toList(),
                      SizedBox(height: 20.h,),
                      const Divider(thickness: 5,),
                      SizedBox(height: 20.h,),
                      Row(
                        children: [
                          const Text("Order Date: "),
                          Text('01',style: const TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),
                      // const SizedBox(height: 10,),
                      // Row(
                      //   children: const [
                      //     Text("Payment Mode: "),
                      //     Text("COD",style: TextStyle(fontWeight: FontWeight.bold),)
                      //   ],
                      // ),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          const Text("Delivery Time Slot: "),
                          Text("6:00 - 9:00",style: const TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          const Text("Delivery Date: "),
                          Text("01-01-2022",style: const TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),

                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          const  Text("Delivery Charges: "),
                           Text("Free")
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const Text("Total Price: "),
                          Text('Rs. 200',style: const TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: MyFilledButton(
                    txt:"View Order Details",
                    color: Colors.blue,
                    width: Get.width-16,
                    borderRadius: 12,
                    ontap: (){
                      Get.to(OrderDetailScreen());
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

  Widget StepperRow(String status){
    Color dotColor = Colors.blue;
    String date = "";
    // if(status==statusList[0])
    // {
    //   date = order.createdDate??"";
    // }
    // else if(status == statusList[1])
    // {
    //   date = order.verifiedDate??"";
    // }
    // // else if(status == statusList[2])
    // // {
    // //   date = order.processedDate??"";
    // // }
    // // else if(status == statusList[3])
    // // {
    // //   date = order.assignedDate??"";
    // // }
    // else if(status == statusList[2])
    // {
    //   date = order.paidDate??"";
    // }
    // else if(status == statusList[3])
    // {
    //   date = order.cancelledDate??"";
    //   dotColor = Colors.red;
    // }

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Container(
                width: 2.w,
                height: 30.h,
                color: Colors.grey,
              ),
            ),
            Row(mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle,color:  Colors.grey,size: 15.r,),
                Container(
                    width: 100.w,
                    child: Text(" "+status)),
                SizedBox(width: 50.w,),
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
