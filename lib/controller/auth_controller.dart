import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:e_store_space/statics/static_var.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:location/location.dart';
import 'package:e_store_space/models/ForgotPassword.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:e_store_space/models/auth_model.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/view/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthController extends GetxController{
  Rx<AuthResponse> user= AuthResponse().obs;
  RxBool isLogedIn = false.obs;
  RxBool progressing = false.obs;
  RxBool checkBoxValue = false.obs;
  RxString account_status = ''.obs;
  RxString user_status = ''.obs;


  Rx<LatLng> latlng = LatLng(0.0, 0.0).obs;
  TextEditingController address = TextEditingController();



  SharedPreferences pref;
  @override
  Future<void> onInit() async {
    pref = await SharedPreferences.getInstance();
    user.value = await User.fromCache();
    isLogedIn.value = user.value == null ? false : true;
    // TODO: implement onInit
    super.onInit();
  }



  void login(String email, String password) async {
      progressing.value = true;
      AuthResponse response = await HttpService.loginUser(
          email,
          password,
      );
      progressing.value = false;
      if(StaticVariable.loginResponseCode == 200){
        User.saveUserToCache(response);
        user.value = response;
        Fluttertoast.showToast(msg: 'You have successfully logged in to app');
        isLogedIn.value = true;
        Get.off(HomePage());
      }
      else{
        Fluttertoast.showToast(msg: 'Invalid Credential');
      }
  }

  logOut(){
    // deleteToken();
    user.value = null;
    User.deleteCachedUser();
    isLogedIn.value = false;
  }


  void register({String name, String email,String password, String city, String phone, String address, bool backtoCartScreen, String shopName, String shopImage})async {

      progressing.value = true;
      AuthResponse response = await HttpService.registerUser(
          name:name,
          email: email,
          password: password,
          address: address,
          city: city,
        phoneNumber: phone,
      );
      progressing.value = false;
      //
      if(StaticVariable.registerResponseCode == 201){
        User.saveUserToCache(response);
        this.user.value = response;
        pref.setString('userId', user.value.user.id.toString());
        this.isLogedIn.value = true;
        Fluttertoast.showToast(msg: 'You are registered in E Store Space');
        Get.off(HomePage());
      }
      else{
        Fluttertoast.showToast(msg: 'Invalid Data');
      }
  }

  // void forgotPassword(String email) async {
  //
  //     progressing.value = true;
  //     ForgotPasswordResponse response = await HttpService.forgotPassword(email
  //     );
  //     progressing.value = false;
  //     if(response!=null){
  //       Fluttertoast.showToast(msg: response.msg);
  //     }
  //     else
  //     {
  //       Get.back();
  //     }
  // }

  updateUser(AuthResponse updatedUSer){
    this.user.value = updatedUSer;
    User.saveUserToCache(updatedUSer);
  }


}