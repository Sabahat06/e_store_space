import 'dart:io';

import 'package:e_store_space/controller/add_store_controller.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/view/seller%20screens/product_category_screen.dart';
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


class AddingStoreScreen extends StatelessWidget {
  AddStoreController controller = Get.put(AddStoreController());
  AuthController authController = Get.find();
  TextEditingController dealName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController dealType = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController shopName = TextEditingController();

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
      body: Obx(
        () => controller.progressing.value
        ? Center(child: CircularProgressIndicator(),)
        : Padding(
          padding: EdgeInsets.all(10.0.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                MyImagePicker(file: file, centerText: "Pick Image",),
                const SizedBox(height: 10),
                MyTextField(
                  // prefixIcon: IconButton(icon: Icon(Icons.person_outlined, color: Colors.blue,)),
                  controller: dealName,
                  label: 'Deal Name',
                ),
                const SizedBox(height: 10),
                MyTextField(
                  // prefixIcon: IconButton(icon: Icon(Icons.lock_outlined, color: Colors.blue,)),
                  controller: dealType,
                  label: 'Deal Type',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  minLines: 2,
                  // any number you need (It works as the rows for the textarea)
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: description,
                  decoration: const InputDecoration(
                    // prefixIcon: IconButton(icon: Icon(Icons.home_outlined, color: Colors.blue,)),
                    fillColor: Colors.blue,
                    focusColor: Colors.blue,
                    hoverColor: Colors.blue,
                    labelText: 'Description',
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
                  txt: 'Adding Deal',
                  fontSize: 20,
                  width: double.infinity,
                  color: Colors.blue,
                  borderRadius: 10,
                  ontap: () async {
                    if(addingDealValidation()) {
                      controller.progressing.value = true;
                      controller.store = await HttpService.addUserStore(
                        token: authController.user.value.token,
                        dealType: dealType.text,
                        description: description.text,
                        name: dealName.text
                      );
                      controller.progressing.value = false;
                      if(StaticVariable.addUserDealResponseCode == 201){
                        Get.off(() => ProductCategoryScreen());
                      }
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

  bool addingDealValidation(){
    if(dealName.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Name is Required');
      return false;
    }
    // else if
    // (!GetUtils.isEmail(dealShortDetail.text)){
    //   Fluttertoast.showToast(msg: 'Email format is not correct');
    //   return false;
    // }
    // else if
    // (dealShortDetail.text.trim().length==0){
    //   Fluttertoast.showToast(msg: 'Email is required');
    //   return false;
    // }
    else if
    (description.text.trim().length == 0){
      Fluttertoast.showToast(msg: 'Phone Number is required');
      return false;
    }
    else if
    (dealType.text.trim().length==0){
      Fluttertoast.showToast(msg: 'City is required');
      return false;
    }
    else
      return true;
  }
}
