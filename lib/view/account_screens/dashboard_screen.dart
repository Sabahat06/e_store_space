import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/dashboard_controller.dart';
import 'package:e_store_space/view/order%20screen/order_status_screen.dart';
import 'package:e_store_space/widgets/my_label.dart';

class DashboardScreen extends StatelessWidget {
DashBoardController dashBoardController = DashBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: const Text('My Dashboard', style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
        () => dashBoardController.progressing.value ? const Center(child: CircularProgressIndicator(),) : Padding(
            padding: const EdgeInsets.all(10.0),
            child: dashBoardController.dashBoard.latestOrder == null
                ? const Center(child: Text('You Have No Latest Order Yet!', style: TextStyle(fontSize: 16, color: Colors.black),),)
                : Column(
              children: [
                GestureDetector(
                  onTap: (){
                    Get.to(OrderStatusScreen(order: dashBoardController.dashBoard.latestOrder));
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
                              Text('Order ID # ${dashBoardController.dashBoard.latestOrder.id}', style: TextStyle(fontSize: 18, color: Colors.black),),
                              const SizedBox(height: 12,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Created On:', style: TextStyle(fontSize: 18, color: Colors.black),),
                                  Text(dashBoardController.dashBoard.latestOrder.createdDate),
                                ],
                              ),
                              const SizedBox(height: 12,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(dashBoardController.dashBoard.latestOrder.label, style: TextStyle(fontSize: 18, color: Colors.black),),
                                  MyLabel(
                                    label: dashBoardController.dashBoard.latestOrder.status,
                                    backGroundColor: Colors.orange,
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
                const SizedBox(height: 20,),
                Divider(color: Colors.grey[800],),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Wallet Balance', style: TextStyle(fontSize: 20, color: Colors.black),),
                    dashBoardController.dashBoard.walletBalance == "0"
                        ? Text(
                            dashBoardController.dashBoard.walletBalance,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          )
                        : double.parse(dashBoardController.dashBoard.walletBalance) <= 0
                          ?  Text(
                              dashBoardController.dashBoard.walletBalance,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.red
                              ),
                            )
                          : Text(
                              dashBoardController.dashBoard.walletBalance,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.green
                              ),
                            )
                  ],
                ),
                Divider(color: Colors.grey[800],),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Delivered Orders', style: TextStyle(fontSize: 20, color: Colors.black),),
                    Text(dashBoardController.dashBoard.deliveredOrders),
                    // Text(controller.dashBoard.deliveredOrders, style: TextStyle(fontSize: 20, color: Colors.black),),
                  ],
                ),
                const SizedBox(height: 10,),
                Divider(color: Colors.grey[800],),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Pending Orders', style: TextStyle(fontSize: 20, color: Colors.black),),
                    Text(dashBoardController.dashBoard.pendingOrders),
                    // Text(controller.dashBoard.pendingOrders, style: TextStyle(fontSize: 20, color: Colors.black),),
                  ],
                ),
                const SizedBox(height: 10,),
                Divider(color: Colors.grey[800],),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Spent', style: TextStyle(fontSize: 20, color: Colors.black),),
                    Text(dashBoardController.dashBoard.totalSpending),
                    // Text(controller.dashBoard.totalSpending, style: TextStyle(fontSize: 20, color: Colors.black),),
                  ],
                ),
              ],
            ),
          ),
      ),

    );
  }
}
