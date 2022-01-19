import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/statics/static_var.dart';
import 'package:e_store_space/widgets/image_pick_widget.dart';
import 'package:e_store_space/widgets/my_filled_button.dart';
import 'package:e_store_space/widgets/my_text_field.dart';

class UpdateProfile extends StatelessWidget {
  AuthController authController = Get.find();
  RxBool checkBoxValue = false.obs;

  TextEditingController name;
  String shopName='';
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController email;
  TextEditingController phone;
  var shopNameCtr=TextEditingController();
  TextEditingController address;
  TextEditingController city;
  File file;


  UpdateProfile() {
    name = TextEditingController(text: authController.user.value.user.name);
    email = TextEditingController(
        text: authController.user.value.user.email
    );
    phone = TextEditingController(
        text: authController.user.value.user.phoneNo
    );
    address = TextEditingController(
        text: authController.user.value.user.address
    );
    city = TextEditingController(
        text: authController.user.value.user.city
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: const Text('Update Profile', style: TextStyle(color: Colors.white),),
      ),
      body: Obx(
        () => authController.progressing.value ? Center(child: CircularProgressIndicator(),) : Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                        width: 150,
                        height: 150,
                        child: Image.asset("assets/image/appimage.jpeg",)
                    ),
                  ),
                  SizedBox(height: 30.h,),
                  MyTextField(controller: name, label: 'Name', prefixIcon: IconButton(icon: Icon(Icons.person_outlined, color: Colors.blue,),)),
                  SizedBox(height: 12.h,),
                  MyTextField(controller: email, label: 'Email',  keyboardType: TextInputType.emailAddress, prefixIcon: IconButton(icon: Icon(Icons.email_outlined, color: Colors.blue,),)),
                  SizedBox(height: 12.h,),
                  MyTextField(controller: phone, label: 'Phone', keyboardType: TextInputType.number, prefixIcon: IconButton(icon: Icon(Icons.phone_outlined, color: Colors.blue,),)),
                  SizedBox(height: 12.h,),
                  MyTextField(controller: address, label: 'Address', prefixIcon: IconButton(icon: Icon(Icons.apartment_outlined, color: Colors.blue,),)),
                  SizedBox(height: 12.h,),
                  MyTextField(controller: city, label: 'City', prefixIcon: IconButton(icon: Icon(Icons.location_city_outlined, color: Colors.blue,),),),
                  SizedBox(height: 12.h,),
                  Row(
                    children: [
                      Checkbox(
                        value: checkBoxValue.value,
                        activeColor: Colors.blue,
                        onChanged: (val) {checkBoxValue.value=val;},
                      ),
                      Text('Update Password', style: TextStyle(fontSize: 16.sp),),
                    ],
                  ),
                  SizedBox(height: 5.h,),
                  checkBoxValue.value
                      ? Column(
                        children: [
                          MyTextField(controller: oldPassword, label: 'Old Password', prefixIcon: IconButton(icon: Icon(Icons.lock_outline, color: Colors.blue,),),),
                          SizedBox(height: 5.h,),
                          MyTextField(controller: newPassword, label: 'New Password', prefixIcon: IconButton(icon: Icon(Icons.lock_outline, color: Colors.blue,),),),
                        ],
                      )
                      : Container(),
                  SizedBox(height: 12.h,),
                  MyFilledButton(
                    ontap: () async {
                    if(updateProfileValidation()){
                      authController.progressing.value = true;
                      var response = await HttpService.updateProfile(
                          // customerId: authController.user.value.user.id,
                          name: name.text,
                          email: email.text,
                          phone: phone.text,
                          address: address.text,
                          city: city.text,
                          oldPassword: oldPassword.text,
                          newPassword: newPassword.text
                        );
                        authController.progressing.value = false;
                        authController.user.value.user.name = name.text;
                        authController.user.value.user.email = email.text;
                        authController.user.value.user.phoneNo = phone.text;
                        authController.user.value.user.city = city.text;
                        authController.user.value.user.address = address.text;
                        authController.updateUser(authController.user.value);
                      }
                      // if(response['password_status']=='success'){
                      //   authController.user.value.password = newPassword.text;
                      //   authController.updateUser(authController.user.value);
                      // }
                      // Fluttertoast.showToast(msg: response['msg']);
                      Get.back();
                    },
                    txt: 'Save Details',
                    borderRadius: 10.r,
                    color: Colors.blue,
                  ),
                ],
              ),
          )
        ),
      ),
    );
  }

  bool updateProfileValidation() {
    if(name.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }
    else if
    (!GetUtils.isEmail(email.text)){
      Fluttertoast.showToast(msg: 'Email format is not correct');
      return false;
    }
    else if(email.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }
    else if(phone.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }
    else if(address.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }
    else if(city.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }
    else
      return true;
  }
}
