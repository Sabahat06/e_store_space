import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/models/order_history_model.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OrderHistoryController extends GetxController{
  AuthController authController = Get.find();
  RxString sorteditem = 'All Orders'.obs;
  RxBool progressing =false.obs;
  OrderHistoryModal modal = OrderHistoryModal(orders: <Orders>[].obs);
  int currentPage = 1;
  List<Orders> orderHistoryBackupList = [];
  OrderHistoryController(){
    // loadOrders();
  }
//  void init(){
//    loadOrders();
//    super.onInit();
//  }

  //Pending,Verified,Processed,In-deliver,Completed,Cancelled

  sortItems(){
    if(sorteditem.value == "All Orders")
    {
      modal.orders.clear();
      modal.orders.addAll(orderHistoryBackupList);
    }
    else
    {
      modal.orders.clear();
      orderHistoryBackupList.forEach((orderHistoryItem) {
        modal.orders.addIf(orderHistoryItem.status.toUpperCase() == sorteditem.value.toUpperCase(), orderHistoryItem);
      });
    }
  }
  SharedPreferences pref;
  // Future<void> loadOrders() async {
  //   pref=await SharedPreferences.getInstance();
  //   progressing.value = true;
  //
  //   HttpService.getOrdersHistory(customerId: pref.getString('userId'), pageNo: 1).then((value) {
  //     currentPage = 1;
  //     orderHistoryBackupList.clear();
  //     orderHistoryBackupList.addAll(value.orders);
  //     if(sorteditem.value != "All Orders")
  //     {
  //       sortItems();
  //     }
  //     else
  //     {
  //       modal.orders.addAll(value.orders);
  //     }
  //     modal.totalPages = value.totalPages;
  //     progressing.value = false;
  //   });
  // }
  //
  // Future<void> loadMoreOrders() async {
  //   currentPage++;
  //   HttpService.getOrdersHistory(
  //       customerId: authController.user.value.id.toString(),
  //       pageNo: currentPage
  //   ).then((result) {
  //     if(result==null)
  //     {
  //       currentPage--;
  //     }
  //     else
  //     {
  //       orderHistoryBackupList.addAll(result.orders);
  //       if(sorteditem.value != "All Orders")
  //       {
  //         sortItems();
  //       }
  //       else
  //       {
  //         modal.orders.addAll(result.orders);
  //       }
  //       progressing.value = false;
  //     }
  //   });
  //
  // }
}

