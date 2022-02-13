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
  TextEditingController shippingAddress = TextEditingController();
  TextEditingController country = TextEditingController();

  File file;
  @override
  Widget build(BuildContext context) {
    authController.sendToken();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: const Text('Create Account', style: TextStyle(color: Colors.white),),
      ),
      body: Obx(
        () => authController.progressing.value ? const Center(child: CircularProgressIndicator(),) : Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
            child: Column(
            children: [
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  child: Image.asset("assets/image/appimage.jpeg",)
                ),
              ),
              // MyImagePicker(file: file, centerText: "Add Photo/ Business Card",),
              // const SizedBox(height: 10),
              MyTextField(
                prefixIcon: IconButton(icon: Icon(Icons.person_outlined, color: Colors.blue,)),
                controller: name,
                label: 'Name',
              ),
              const SizedBox(height: 10),
              // MyTextField(controller: shopName, label: 'Shop Name',),
              // const SizedBox(height: 10),
              MyTextField(
                prefixIcon: IconButton(icon: Icon(Icons.email_outlined, color: Colors.blue,)),
                controller: email,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              MyTextField(
                prefixIcon: IconButton(icon: Icon(Icons.phone_outlined, color: Colors.blue,)),
                controller: phone,
                label: 'Phone Number',
              ),
              const SizedBox(height: 10),
              MyTextField(
                prefixIcon: IconButton(icon: Icon(Icons.lock_outlined, color: Colors.blue,)),
                controller: password,
                label: 'Password',
              ),
              const SizedBox(height: 10),
              TextFormField(
                minLines: 2,
                // any number you need (It works as the rows for the textarea)
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: address,
                decoration: const InputDecoration(
                  prefixIcon: IconButton(icon: Icon(Icons.home_outlined, color: Colors.blue,)),
                  fillColor: Colors.blue,
                  focusColor: Colors.blue,
                  hoverColor: Colors.blue,
                  labelText: 'Enter Full Address',
                  hintStyle:
                  TextStyle(color: Colors.black54, fontSize: 12),
                  labelStyle:
                  TextStyle(color: Colors.blue, fontSize: 16),
                  disabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.blue)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.blue)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.blue)),
                  border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.blue)),
                  // hintText: label,
                ),
              ),
              const SizedBox(height: 10),
              MyTextField(
                prefixIcon: IconButton(icon: Icon(Icons.home_outlined, color: Colors.blue,)),
                controller: shippingAddress,
                label: 'Shipping Address',
              ),
              const SizedBox(height: 10),
              MyTextField(
                prefixIcon: IconButton(icon: Icon(Icons.location_city_outlined, color: Colors.blue,)),
                controller: city,
                label: 'City',
              ),
              const SizedBox(height: 10),
              MyTextField(
                prefixIcon: IconButton(icon: Icon(Icons.location_city_outlined, color: Colors.blue,)),
                controller: country,
                label: 'Country',
              ),
              const SizedBox(height: 20),
              MyFilledButton(
                txt: 'Register',
                fontSize: 20,
                width: double.infinity,
                color: Colors.blue,
                borderRadius: 10,
                ontap: () async {
                  if(registerValidation()) {
                    authController.register(
                      name: name.text,
                      email: email.text,
                      phone: phone.text,
                      password: password.text,
                      address: address.text,
                      city: city.text,
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
    if(name.text.trim().length<=5){
      Fluttertoast.showToast(msg: 'The name must be at least 5 characters');
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
    else
      return true;
  }
}
