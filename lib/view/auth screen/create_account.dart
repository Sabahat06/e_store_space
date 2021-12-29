import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/settings/color_palates.dart';
import 'package:e_store_space/statics/static_var.dart';
import 'package:e_store_space/widgets/image_pick_widget.dart';
import 'package:e_store_space/widgets/my_filled_button.dart';
import 'package:e_store_space/widgets/my_text_field.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';


class CreateAccount extends StatelessWidget {
  AuthController authController = Get.find();
  bool backToCartScreen;
  CreateAccount(this.backToCartScreen);
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController shopName = TextEditingController();

  File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: const Text('Create Account', style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
        () => authController.progressing.value ? const Center(child: CircularProgressIndicator(),) : Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
            child: Column(
            children: [
              const SizedBox(height: 10),
              MyImagePicker(file: file, centerText: "Add Photo/ Business Card",),
              const SizedBox(height: 10),
              MyTextField(controller: name, label: 'Name',),
              const SizedBox(height: 10),
              MyTextField(controller: shopName, label: 'Shop Name',),
              const SizedBox(height: 10),
              MyTextField(controller: email, label: 'Email', keyboardType: TextInputType.emailAddress,),
              const SizedBox(height: 10),
              MyTextField(controller: phone, label: 'Phone',),
              const SizedBox(height: 10),
              MyTextField(controller: password, label: 'Password',),
              const SizedBox(height: 10),
              TextFormField(
                minLines: 2,
                // any number you need (It works as the rows for the textarea)
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: address,
                decoration: const InputDecoration(
                  fillColor: ColorPalette.orange,
                  focusColor: ColorPalette.orange,
                  hoverColor: ColorPalette.orange,
                  labelText: 'Enter Full Address',
                  hintStyle:
                  TextStyle(color: Colors.black54, fontSize: 12),
                  labelStyle:
                  TextStyle(color: Colors.black, fontSize: 16),
                  disabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorPalette.orange)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorPalette.orange)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorPalette.orange)),
                  border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorPalette.orange)),
                  // hintText: label,
                ),
              ),
              const SizedBox(height: 10),
              MyTextField(controller: city, label: 'City',),
              const SizedBox(height: 10),
              MyFilledButton(
                txt: 'Register',
                width: double.infinity,
                color: Colors.orange,
                borderRadius: 10,
                ontap: () async {
                  if(registerValidation()) {
                    authController.register(
                      shopImage: StaticVariable.baseString,
                      name: name.text,
                      email: email.text,
                      phone: phone.text,
                      password: password.text,
                      address: address.text,
                      city: city.text,
                      backtoCartScreen: backToCartScreen,
                      shopName: shopName.text
                    );
                  }
                },
              ),
            ],
          ),
            ),
          ),
      ),
    );
  }

  // Future<void> GetAddressFromLatLong(Position position)async {
  //   List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  //   print(placemarks);
  //   Placemark place = placemarks[0];
  //   address.text = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  // }

  bool registerValidation(){
    if(name.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Name is Required');
      return false;
    }else if
    (!GetUtils.isEmail(email.text)){
      Fluttertoast.showToast(msg: 'Email format is not correct');
      return false;
    }
    else if
    (email.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }else if
    (phone.text.trim().length == 0){
      Fluttertoast.showToast(msg: 'Phone Number is required');
      return false;
    }
    else if
    (phone.text.trim().length < 11){
      Fluttertoast.showToast(msg: 'Enter Valid Phone Number');
      return false;
    }
    else if
    (address.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Address is required');
      return false;
    }else if
    (city.text.trim().length==0){
      Fluttertoast.showToast(msg: 'City is required');
      return false;
    }
    else if
    (shopName.text.trim().length==0){
      Fluttertoast.showToast(msg: 'City is required');
      return false;
    }
    else
      return true;
  }
}
