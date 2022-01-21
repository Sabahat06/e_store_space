// import 'package:get/get.dart';
// import 'package:e_store_space/controller/auth_controller.dart';
// import 'package:e_store_space/models/dashboard.dart';
// import 'package:e_store_space/services/http_services.dart';
//
// class DashBoardController extends GetxController {
//   AuthController authController = Get.find();
//   RxBool progressing = false.obs;
//
//   DashBoard dashBoard = DashBoard();
//   DashBoardController() {
//     loadDashBoard();
//   }
//
//   loadDashBoard() async {
//     progressing.value = true;
//     // dashBoard = await HttpService.getDashboard(authController.user.value.id);
//     progressing.value = false;
//   }
// }