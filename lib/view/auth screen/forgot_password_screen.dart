import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/settings/color_palates.dart';

class ForgotPasswordScreen extends StatelessWidget {
  AuthController controller = Get.find();
  TextEditingController email=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: const Text('Forgot Password', style: TextStyle(color: Colors.white,),),
      ),
      body: controller.progressing.value ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15,),
              MyTextField(
                prefixIcon: IconButton(icon: Icon(Icons.email_outlined, color: Colors.blue,)),
                controller: email,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15,),
              GestureDetector(
                onTap: () async {
                  if(forgotPasswordValidation()){
                    controller.progressing.value = true;
                    var response = HttpService.getAllPages();
                    controller.progressing.value = false;
                    // controller.forgotPassword(email.text);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 40,
                  width: double.infinity,
                  child: const Center(child: Text('Send Password', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)),
                ),
              ),
              const SizedBox(height: 15,),
              GestureDetector(
                onTap: () {Get.back();},
                child: const Center(
                  child: Text(
                    'Back to Login',
                    style: TextStyle(
                      color:Colors.blue,
                      fontSize: 18,
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
    if(email.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }
    else if
    (!GetUtils.isEmail(email.text)){
      Fluttertoast.showToast(msg: 'Email format is not correct');
      return false;
    }
    else
      return true;
  }
}
