import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/dashboard_controller.dart';
import 'package:e_store_space/view/order%20screen/order_status_screen.dart';
import 'package:e_store_space/widgets/my_label.dart';

class DashboardScreen extends StatelessWidget {
// DashBoardController dashBoardController = DashBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: const Text('My Dashboard', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Get.to(OrderStatusScreen());
              },
              child: Column(
                children: [
                  const Text('Your Latest Order', style: TextStyle(fontSize: 20,),),
                  const SizedBox(height: 15,),
                  Container(
                    width: double.infinity,
                    height: 125,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(color: Colors.grey[500]),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order ID # 01', style: TextStyle(fontSize: 18.sp, color: Colors.black),),
                          SizedBox(height: 12.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Created On:', style: TextStyle(fontSize: 18.sp, color: Colors.black),),
                              Text('01-01-2022', style: TextStyle(fontSize: 16.sp, color: Colors.black),),
                            ],
                          ),
                          const SizedBox(height: 12,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Label', style: TextStyle(fontSize: 18.sp, color: Colors.black),),
                              MyLabel(
                                label: 'Status',
                                backGroundColor: Colors.blue,
                                borderRadius: 5,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            Divider(color: Colors.grey[800],),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Wallet Balance', style: TextStyle(fontSize: 20.sp, color: Colors.black),),
                Text(
                  "2000",
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.blue
                  ),
                )
                // dashBoardController.dashBoard.walletBalance == "0"
                //     ? Text(
                //         dashBoardController.dashBoard.walletBalance,
                //         style: const TextStyle(
                //           fontSize: 20,
                //         ),
                //       )
                //     : double.parse(dashBoardController.dashBoard.walletBalance) <= 0
                //       ? Text(
                //           dashBoardController.dashBoard.walletBalance,
                //           style: const TextStyle(
                //             fontSize: 20,
                //             color: Colors.red
                //           ),
                //         )
                //       : Text(
                //           dashBoardController.dashBoard.walletBalance,
                //           style: const TextStyle(
                //             fontSize: 20,
                //             color: Colors.green
                //           ),
                //         )
              ],
            ),
            Divider(color: Colors.grey[800],),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivered Orders', style: TextStyle(fontSize: 20.sp, color: Colors.black),),
                Text("2", style: TextStyle(fontSize: 20.sp, color: Colors.black),),
                // Text(controller.dashBoard.deliveredOrders, style: TextStyle(fontSize: 20, color: Colors.black),),
              ],
            ),
            SizedBox(height: 10.h,),
            Divider(color: Colors.grey[800],),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pending Orders', style: TextStyle(fontSize: 20.sp, color: Colors.black),),
                Text("1", style: TextStyle(fontSize: 20.sp, color: Colors.black),),
                // Text(controller.dashBoard.pendingOrders, style: TextStyle(fontSize: 20, color: Colors.black),),
              ],
            ),
            SizedBox(height: 10.h,),
            Divider(color: Colors.grey[800],),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Spent', style: TextStyle(fontSize: 20.sp, color: Colors.black),),
                Text("1000", style: TextStyle(fontSize: 20.sp, color: Colors.black),),
                // Text(controller.dashBoard.totalSpending, style: TextStyle(fontSize: 20, color: Colors.black),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
