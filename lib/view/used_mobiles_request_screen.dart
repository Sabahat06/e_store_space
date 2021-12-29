// import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/my_moblies_controller.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/settings/color_palates.dart';
import 'package:e_store_space/statics/static_var.dart';
import 'package:e_store_space/widgets/image_pick_widget.dart';
import 'package:e_store_space/widgets/my_filled_button.dart';
import 'package:e_store_space/widgets/my_text_field.dart';

import 'account_screens/my_used_mobile_screen.dart';

class UsedMobileRequestScreen extends StatelessWidget {
  UsedMobileRequestScreen({Key key}) : super(key: key);

  File file;
  RxBool isloading = false.obs;

  // final picker= ImagePicker();

  var nameCtr = TextEditingController();
  var priceCtr = TextEditingController();
  MyUsedMobilesController controller = MyUsedMobilesController();

  var descriptionCtr = TextEditingController();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {

    StaticVariable.userId=authController.user.value.id;
    final ProgressDialog pr = ProgressDialog(
      context, type: ProgressDialogType.Normal, isDismissible: false,
      // showLogs: true/false
    );
    pr.style(message: 'progressing');


    return Scaffold(
      appBar: AppBar(title: const Text('ڈیوائس اپ لوڈ'),),
      body: Obx(
        () => controller.isLoading.value ? Center(child: CircularProgressIndicator(),) : Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyImagePicker(file: file, centerText: "",),
                            const SizedBox(
                              height: 20,
                            ),
                            MyTextField(controller: nameCtr, label: 'ڈیوائس کا نام درج کریں۔',),
                            const SizedBox(height: 7,),
                            MyTextField(controller: priceCtr, label: 'قیمت درج کریں۔',),
                            const SizedBox(height: 10,),
                            TextFormField(
                              minLines: 4,
                              // any number you need (It works as the rows for the textarea)
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: descriptionCtr,
                              decoration: const InputDecoration(
                                fillColor: ColorPalette.orange,
                                focusColor: ColorPalette.orange,
                                hoverColor: ColorPalette.orange,
                                labelText: 'ڈیوائس کی تفصیل درج کریں۔',
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
                            const SizedBox(height: 25,),
                            const SizedBox(height: 25,),
                            Container(
                                child: MyFilledButton(
                                    ontap: () async {
                                    if(sendRequestValidation()){
                                      controller.isLoading.value = true;
                                      var response = await HttpService.addLoggedInUserMobile(
                                          image: StaticVariable.baseString,
                                          mobileName: nameCtr.text.trim(),
                                          customerId: authController.user.value.id,
                                          description: descriptionCtr.text.trim(),
                                          price: priceCtr.text.trim()
                                      );
                                      controller.isLoading.value= true;
                                      if(response['status']=='1'){
                                        Get.off(() => MyUsedMobileScreen());
                                      }
                                    }
                              },
                              color: ColorPalette.orange,
                              width: double.infinity,
                              height: 40,
                              borderRadius: 10,
                              txt: 'Upload',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }




  // Future getImage() async {
  //   final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  //
  //   // setState(() {
  //
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //
  //   // });
  // }

  bool sendRequestValidation(){
    if (nameCtr.text.isEmpty) {
      Fluttertoast.showToast(msg: 'please Enter Name');
      return false;
    } else if (priceCtr.text.isEmpty) {
      Fluttertoast.showToast(msg: 'please Enter price');
      return false;
    } else if (descriptionCtr.text.isEmpty) {
      Fluttertoast.showToast(msg: 'please Enter description');
      return false;
    } else if (StaticVariable.baseString.isEmpty) {
      Fluttertoast.showToast(msg: 'Please select an Image');
      return false;
    } else {
      return true;
    }
  }
}
