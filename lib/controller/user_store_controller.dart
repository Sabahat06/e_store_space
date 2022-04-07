import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/models/user_store.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:get/get.dart';

class UserStoreController extends GetxController{
  AuthController authController = Get.find();
  Rx<UserStore> userStore = UserStore().obs;
  RxBool progressing = false.obs;

  UserStoreController(){
    loadUserStore();
  }


  loadUserStore() async {
    progressing.value = true;
    userStore.value = await HttpService.getUserStore(token: authController.user.value.token);
    progressing.value = false;
  }
}