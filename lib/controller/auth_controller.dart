import 'dart:io';
import 'package:device_info/device_info.dart';
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
  Rx<User> user= User().obs;
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
    user.value =await User.fromCache();
    isLogedIn.value = user.value==null?false : true;
    // TODO: implement onInit
    super.onInit();
  }



  // void login(String email, String password) async {
  //     progressing.value = true;
  //     AuthResponse response = await HttpService.loginUser(
  //         email,
  //         password
  //     );
  //     progressing.value = false;
  //     if(response.user==null){
  //       Fluttertoast.showToast(msg: response.msg);
  //     }
  //     else
  //     {
  //
  //       User.saveUserToCache(response.user);
  //       user.value = response.user;
  //
  //       pref.setString('userId',user.value.id);
  //       isLogedIn.value = true;
  //       Get.off(HomePage());
  //
  //       sendToken(user.value.id);
  //     }
  // }

  logOut(){
    // deleteToken();
    user.value = null;
    User.deleteCachedUser();
    isLogedIn.value = false;
  }
  // void register({String name, String email,String password, String city, String phone, String address, bool backtoCartScreen, String shopName, String shopImage})async {
  //
  //     progressing.value = true;
  //     AuthResponse response = await HttpService.registerUser(
  //         name:name,
  //         email: email,
  //         phone: phone,
  //         password: password,
  //         address: address,
  //         city: city,
  //         shopName: shopName,
  //         shopPhoto: shopImage
  //     );
  //     progressing.value = false;
  //     if(response.user==null){
  //       Fluttertoast.showToast(msg: response.msg);
  //     }
  //     else
  //     {
  //
  //       Fluttertoast.showToast(msg: response.msg);
  //       User.saveUserToCache(response.user);
  //       this.user.value = response.user;
  //       pref.setString('userId', user.value.id);
  //       this.isLogedIn.value = true;
  //       sendToken(user.value.id);
  //       backtoCartScreen ? Get.back() : Get.off(HomePage());
  //     }
  //
  // }

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

  // updateUser(User updatedUSer){
  //   this.user.value = updatedUSer;
  //   User.saveUserToCache(updatedUSer);
  // }
  //
  // sendToken(String id) async {
  //   String token = await  FirebaseMessaging.instance.getToken();
  //   String deviceID = await getDeviceId();
  //   String status = await HttpService.createToken(id, deviceID, token);
  //   // print("notification status: $status");
  // }
  //
  // deleteToken() async {
  //   String deviceID = await getDeviceId();
  //   HttpService.deleteToken(deviceID);
  // }

  static Future<String> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }


  Future<void> loadCurrentLocation() async {
    Location location = Location();
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus == PermissionStatus.denied) {
        return;
      }
    }
    LocationData locationData = await location.getLocation();
    latlng.value= LatLng(locationData.latitude, locationData.longitude);
  }


}