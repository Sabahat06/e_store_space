import 'package:e_store_space/models/order_detail_model.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/models/order_history_model.dart';
import 'package:e_store_space/services/http_services.dart';


class OrderHistoryController extends GetxController{
  AuthController authController = Get.find();
  RxBool progressing =false.obs;
  OrderHistoryModel orderHistoryModal = OrderHistoryModel();
  OrderDetailModel orderDetailModel = OrderDetailModel();
  OrderHistoryController(){
    loadOrders();
  }
  loadOrders() async {
    progressing.value =true;
    orderHistoryModal = await HttpService.getOrderHistory(token: authController.user.value.token);
    progressing.value =false;
  }
}

