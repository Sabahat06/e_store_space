import 'package:get/get.dart';
import 'package:e_store_space/services/http_services.dart';


class OrderStatusScreenController extends GetxController{
  RxBool progressing = false.obs;


  cancelOrder(String orderId) async {
    progressing.value= true;
    var result=  await HttpService.cancelOrder(orderId: orderId);
    return result;
  }
}