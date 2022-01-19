import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/models/user_store.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:get/get.dart';

class UserStoreController extends GetxController{
  AuthController authController = Get.find();
  UserStore userStore = UserStore();

  // Future<void> onInit() async {
  //   loadUserStore();
  //   // TODO: implement onInit
  //   super.onInit();
  // }
  UserStoreController(){
    loadUserStore();
  }


  loadUserStore() async {
    userStore = await HttpService.getUserStore(token: authController.user.value.token);
  }
}