import 'package:get/get.dart';

class BottomBarController extends GetxController{
  RxInt currentBNBIndex = 0.obs;
  RxBool isSeller = false.obs;
  RxBool isAffiliate = false.obs;


  void indexChanged(int index){
    currentBNBIndex.value = index;
  }
}