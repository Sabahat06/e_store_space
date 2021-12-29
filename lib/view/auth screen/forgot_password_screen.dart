import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/settings/color_palates.dart';

class ForgotPasswordScreen extends StatelessWidget {
  AuthController controller = Get.find();
  var emailCtr=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: const Text('Forgot Password', style: TextStyle(color: Colors.black,),),
      ),
      body: controller.progressing.value ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                obscureText: false,
                controller: emailCtr,
                cursorColor: ColorPalette.orange,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 15,),
              GestureDetector(
                onTap: () {
                  if(forgotPasswordValidation()){
                    controller.forgotPassword(emailCtr.text);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorPalette.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 40,
                  width: double.infinity,
                  child: const Center(child: Text('Send Password', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),)),
                ),
              ),
              const SizedBox(height: 15,),
              GestureDetector(
                onTap: () {Get.back();},
                child: const Center(
                  child: Text(
                    'Back to Login',
                    style: TextStyle(
                      color:ColorPalette.orange,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool forgotPasswordValidation() {
    if(emailCtr.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }
    else if
    (!GetUtils.isEmail(emailCtr.text)){
      Fluttertoast.showToast(msg: 'Email format is not correct');
      return false;
    }
    else
      return true;
  }
}
