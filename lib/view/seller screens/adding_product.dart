import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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


class AddingProductScreen extends StatelessWidget {
  AuthController authController = Get.find();
  TextEditingController productName = TextEditingController();
  TextEditingController productShortDetail = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController productType = TextEditingController();
  TextEditingController productQuantity = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productColor = TextEditingController();

  File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: const Text('Add Deal', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Center(
              //   child: Container(
              //       width: 150,
              //       height: 150,
              //       child: Image.asset("assets/image/appimage.jpeg",)
              //   ),
              // ),
              const SizedBox(height: 10),
              MyImagePicker(file: file, centerText: "Pick Image",),
              const SizedBox(height: 15),
              MyTextField(
                // prefixIcon: IconButton(icon: Icon(Icons.person_outlined, color: Colors.blue,)),
                controller: productName,
                label: 'Product Name',
              ),
              const SizedBox(height: 10),
              MyTextField(
                // prefixIcon: IconButton(icon: Icon(Icons.lock_outlined, color: Colors.blue,)),
                controller: productType,
                label: 'Product Type',
              ),
              const SizedBox(height: 10),
              MyTextField(
                // prefixIcon: IconButton(icon: Icon(Icons.lock_outlined, color: Colors.blue,)),
                controller: productQuantity,
                label: 'Product Quantity',
              ),
              const SizedBox(height: 10),
              MyTextField(
                // prefixIcon: IconButton(icon: Icon(Icons.lock_outlined, color: Colors.blue,)),
                controller: productColor,
                label: 'Product Color',
              ),
              const SizedBox(height: 10),
              TextFormField(
                minLines: 2,
                // any number you need (It works as the rows for the textarea)
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: productShortDetail,
                decoration: const InputDecoration(
                  // prefixIcon: IconButton(icon: Icon(Icons.home_outlined, color: Colors.blue,)),
                  fillColor: Colors.blue,
                  focusColor: Colors.blue,
                  hoverColor: Colors.blue,
                  labelText: 'Product Short Detail',
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
              TextFormField(
                minLines: 2,
                // any number you need (It works as the rows for the textarea)
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: productDescription,
                decoration: const InputDecoration(
                  // prefixIcon: IconButton(icon: Icon(Icons.home_outlined, color: Colors.blue,)),
                  fillColor: Colors.blue,
                  focusColor: Colors.blue,
                  hoverColor: Colors.blue,
                  labelText: 'Product Description',
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
              const SizedBox(height: 20),
              MyFilledButton(
                txt: 'Adding Product',
                fontSize: 20,
                width: double.infinity,
                color: Colors.blue,
                borderRadius: 10,
                ontap: () async {
                  Get.back();
                  // if(registerValidation()) {
                  //   authController.register(
                  //       shopImage: StaticVariable.baseString,
                  //       name: name.text,
                  //       email: email.text,
                  //       phone: phone.text,
                  //       password: password.text,
                  //       address: address.text,
                  //       city: city.text,
                  //       backtoCartScreen: backToCartScreen,
                  //       shopName: shopName.text
                  //   );
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool addingProductValidation(){
    if(productName.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Name is Required');
      return false;
    }else if
    (!GetUtils.isEmail(productShortDetail.text)){
      Fluttertoast.showToast(msg: 'Email format is not correct');
      return false;
    }
    else if
    (productShortDetail.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }else if
    (productType.text.trim().length == 0){
      Fluttertoast.showToast(msg: 'Phone Number is required');
      return false;
    }
    else if
    (productQuantity.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Address is required');
      return false;
    }
    else if
    (productColor.text.trim().length==0){
      Fluttertoast.showToast(msg: 'City is required');
      return false;
    }
    else
      return true;
  }
}
