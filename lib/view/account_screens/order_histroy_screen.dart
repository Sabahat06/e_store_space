import 'package:e_store_space/models/order_history_model.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/view/account_screens/order_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/controller/order_history_screen_controller.dart';
import 'package:e_store_space/widgets/my_label.dart';


class OrderHistoryScreen extends StatelessWidget {
  AuthController authController = Get.find();
  OrderHistoryController controller = OrderHistoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
            },
          color: Colors.white,
        ),
        leadingWidth: 30,
        title: const Text('Orders History', style: TextStyle(color: Colors.white),),
      ),
      body: Obx(
        () => controller.progressing.value
            ? Center(child: CircularProgressIndicator(),)
            : controller.orderHistoryModal.orderHistory == null || controller.orderHistoryModal.orderHistory.length == 0
            ? Center(child: Text('You Have No Order Yet', style: TextStyle(fontSize: 18, color: Colors.black),),)
            : Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.h,),
                ListView.builder(
                  itemCount: controller.orderHistoryModal.orderHistory.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index,)=> renderListItem(controller.orderHistoryModal.orderHistory[index]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  renderListItem(OrderHistory order){
    return GestureDetector(
      onTap: () async {
        controller.progressing.value = true;
        controller.orderDetailModel = await HttpService.getOrderDetails(order.id.toString(), authController.user.value.token);
        controller.progressing.value = false;
        Get.to(OrderDetailScreen(controller.orderDetailModel));
      },
      child: Card(
        elevation: 2,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 110.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order ID # ${order.id}', style: TextStyle(fontSize: 18.sp, color: Colors.black),),
                    SizedBox(height: 12.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Created On:', style: TextStyle(fontSize: 18.sp, color: Colors.black),),
                        Text(order.deliveryDate, style: TextStyle(fontSize: 18.sp, color: Colors.black),),
                      ],
                    ),
                    SizedBox(height: 12.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Price: ${order.price}", style: TextStyle(fontSize: 18.sp, color: Colors.black),),
                        MyLabel(
                          label: order.status,
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
          ],
        ),
      ),
    );
  }
}



