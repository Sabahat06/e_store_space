import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/models/used_mobile_model.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/view/account_screens/my_used_mobile_screen.dart';

class UsedMobileController extends GetxController{
  RxInt currentPage = 1.obs;
  String customerId='0';
  RxInt currentSearchPage = 1.obs;
  AuthController authController=Get.find();

  UsedMobileController(this.customerId){
    LoadAllUsedMobiles(loadMore: false);
  }
  Rx<UsedMobileModel> usedMobile = UsedMobileModel(products: <UsedProducts>[].obs,totalPages: 0).obs;
  RxBool isLoading = false.obs;
  RxBool search = false.obs;

  LoadAllUsedMobiles({@required bool loadMore})async{
    if(!loadMore)
    {
      currentPage = 1.obs;
      isLoading.value = true;
      usedMobile.value = await HttpService.getUsedMobile(customerId, currentPage.value);
      isLoading.value = false;
    }
    else
    {
      currentPage.value++;
      UsedMobileModel usedMobileResult = await HttpService.getUsedMobile(customerId, currentPage.value);
      usedMobile.value.products.addAll(usedMobileResult.products);
      update();
      print("added");
    }


    // isLoading.value = true;
    // usedMobile.value = await HttpService.getUsedMobile(customerId);
    // isLoading.value = false;
  }

  deleteMyMobile(String id)async{
    var response = await HttpService.deleteMyUsedMobile(id: id);
    if(response['status']=='1'){
      LoadAllUsedMobiles();
    }
  }

  void addMobile({String image, String mobileName, String customerId, String description, String price}){
    HttpService.addLoggedInUserMobile(image: image,mobileName: mobileName,customerId: customerId,description: description,price: price);
  }



}