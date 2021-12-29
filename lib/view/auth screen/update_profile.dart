import 'dart:io';

import 'package:flutter/material.dart';
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
    name = TextEditingController(text: authController.user.value.name);
    email = TextEditingController(text: authController.user.value.email);
    phone = TextEditingController(text: authController.user.value.phone);
    address = TextEditingController(text: authController.user.value.address);
    city = TextEditingController(text: authController.user.value.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
          leadingWidth: 30,
          title: const Text('Update Profile', style: TextStyle(color: Colors.black),),
        ),
        body: Obx(
              () => authController.progressing.value ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                          MyImagePicker(
                            file: file,
                            centerText: "Add Photo/ Business Card",
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          MyTextField(
                            controller: name,
                            label: 'Name',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          MyTextField(
                            controller: email,
                            label: 'Email',
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          MyTextField(
                            controller: phone,
                            label: 'Phone',
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          MyTextField(
                            controller: shopNameCtr,
                            label: 'Shop Name',
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          MyTextField(
                            controller: address,
                            label: 'Address',
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          MyTextField(
                            controller: city,
                            label: 'City',
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: authController.checkBoxValue.value,
                                activeColor: Colors.orange,
                                onChanged: (val) {authController.checkBoxValue.value=val;},
                        ),
                        const Text('Update Password', style: TextStyle(fontSize: 16),),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    authController.checkBoxValue.value
                        ? Column(
                      children: [
                        MyTextField(controller: oldPassword, label: 'Old Password',),
                        const SizedBox(height: 5,),
                        MyTextField(controller: newPassword, label: 'New Password',),
                      ],
                    )
                        : Container(),
                    const SizedBox(height: 12,),
                    MyFilledButton(
                      ontap: () async {
                        if(updateProfileValidation()){
                                authController.progressing.value = true;
                          var response = await HttpService.updateProfile(
                              customerId: authController.user.value.id,
                                    name: name.text,
                                    email: email.text,
                                    phone: phone.text,
                                    address: address.text,
                                    shopName: shopNameCtr.text,
                                    shopPhoto: StaticVariable.baseString,
                                    city: city.text,
                                    updatePassword:
                                        authController.checkBoxValue.value,
                                    oldPassword: oldPassword.text,
                                    newPassword: newPassword.text);
                          authController.progressing.value = false;
                          if(response['status']=='success'){
                            authController.user.value.name = name.text;
                            authController.user.value.email = email.text;
                            authController.user.value.phone = phone.text;
                            authController.user.value.city = city.text;
                            authController.user.value.address = address.text;
                            authController.updateUser(authController.user.value);
                          }
                          if(response['password_status']=='success'){
                            authController.user.value.password = newPassword.text;
                            authController.updateUser(authController.user.value);
                          }
                          Fluttertoast.showToast(msg: response['msg']);
                          Get.back();
                        }
                      },
                      txt: 'Save Details',
                      borderRadius: 10,
                      color: Colors.orange,
                    ),
                  ],
                )
            ),
          ),
        )
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
    }    else if(shopNameCtr.text.trim().length==0){
      Fluttertoast.showToast(msg: 'shop name  is required');
      return false;
    }
    else
      return true;
  }
}
