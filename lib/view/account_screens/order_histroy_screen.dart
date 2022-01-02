import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/controller/order_history_screen_controller.dart';
import 'package:e_store_space/models/order_history_model.dart';
import 'package:e_store_space/settings/color_palates.dart';
import 'package:e_store_space/view/home_screen_tabs/account_screen_tab.dart';
import 'package:e_store_space/view/homepage.dart';
import 'package:e_store_space/view/order%20screen/order_status_screen.dart';
import 'package:e_store_space/widgets/my_label.dart';


class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryController controller = OrderHistoryController();
  // AuthController authController = Get.find();
  // RefreshController refreshController = RefreshController();
  // final BottomBarController _barController=Get.find();

  List<String> sortedTerms = ['All Orders','Pending','Verified','Completed','Cancelled'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.off(HomePage());
            // Get.back();
            },
          color: Colors.white,
        ),
        leadingWidth: 30,
        title: const Text('Orders History', style: TextStyle(color: Colors.white),),
      ),
      body:
      // authController.user.value.id == null?const Center(child:  Text('Please login to see you history'),):

      Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(
            ()=> Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[600],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Text(controller.sorteditem.value, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold,)),
                        DropdownButton<String>(
                            isExpanded: true,
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 3.0),
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey[600],
                              ),
                            ),
                            iconSize: 30,
                            style: TextStyle(color: ColorPalette.green),
                            underline: Container(
                              color: Colors.transparent,
                            ),
                            onChanged: (newValue) {
                              controller.sorteditem.value = newValue;
                              // controller.sortItems();
                            },
                            items: sortedTerms.map((value) =>
                                DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: TextStyle(color: Colors.black),),
                                )
                            ).toList()
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                Container(
                  height: Get.height-190.h,
                  child:
                  //     controller.modal.orders.length ==0
                  //     ? Center(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       IconButton(icon: Icon(Icons.search), iconSize: 50,),
                  //       SizedBox(height: 15,),
                  //       Text('You have no orders yet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  //     ],
                  //   ),
                  // )
                  //     :
                  //   Center(
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: const [
                  //         IconButton(icon: Icon(Icons.search), iconSize: 50,),
                  //         SizedBox(height: 15,),
                  //         Text('No Order Found', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  //         SizedBox(height: 15,),
                  //         Text('Manage your orders here', style: TextStyle(fontSize: 16),),
                  //       ],
                  //     ),
                  //   )
                  //       :
                  // SmartRefresher(
                  //     controller: refreshController,
                  //     onLoading: (){
                  //       controller.loadMoreOrders().then((value) =>refreshController.loadComplete());
                  //     },
                  //     onRefresh: (){
                  //       controller.loadOrders().then((value) => refreshController.refreshCompleted());
                  //     },
                  //     enablePullUp: controller.currentPage<controller.modal.totalPages.value,
                  //     child:
                      ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (context, index)=> renderListItem(),
                      ),
                  //   ),
                //   ),
                ),
//                ...controller.orderHistoryList.map((order) => renderListItem(order)).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  renderListItem(
      // Orders order
      ){
    // Color labelColor = Colors.black54;
    // if(order.status== "Completed")
    // {
    //   labelColor = ColorPalette.green;
    // }
    // if(order.status== "Pending")
    // {
    //   labelColor = ColorPalette.orange;
    // }
    // if(order.status== "Cancelled")
    // {
    //   labelColor = Colors.red;
    // }
    return GestureDetector(
      onTap: (){
        Get.to(OrderStatusScreen());
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 110.h,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                border: Border.all(color: Colors.grey[800]),
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
                      Text("01-01-2022", style: TextStyle(fontSize: 18.sp, color: Colors.black),),
                    ],
                  ),
                  SizedBox(height: 12.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("label", style: TextStyle(fontSize: 18.sp, color: Colors.black),),
                      MyLabel(
                        label: "Order Status",
                        backGroundColor: Colors.blue,
                        // height: 35,
                        // width: 100,
                        borderRadius: 5,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h,),
        ],
      ),
    );
  }
}



