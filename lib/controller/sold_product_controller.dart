import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/models/sold_product_model.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:get/get.dart';

class SoldProductController extends GetxController{
  RxBool progressing = false.obs;
  SoldProductModel soldProductModel = SoldProductModel();
  AuthController authController = Get.find();

  SoldProductController(){
    loadSoldProduct();
  }

  loadSoldProduct() async {
    progressing.value = true;
    soldProductModel = await HttpService.getSoldProduct(token: authController.user.value.token);
    progressing.value = false;
  }
}