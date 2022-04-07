import 'package:e_store_space/models/order_detail_model.dart';
import 'package:get/get.dart';

class OrderDetailController extends GetxController{
  OrderDetailModel orderDetailModel = OrderDetailModel();

  OrderDetailController(String id){
    loadOrder();
  }

  loadOrder(){}

}