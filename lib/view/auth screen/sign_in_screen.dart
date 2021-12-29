import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/settings/color_palates.dart';
import 'package:e_store_space/widgets/my_text_field.dart';

import 'forgot_password_screen.dart';


class SignInScreen extends StatelessWidget {
  bool returnToOrderScreen;
  SignInScreen({this.returnToOrderScreen});

  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: const Text('Sign In', style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
        () => controller.progressing.value ? Center(child: CircularProgressIndicator(),) :
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/image/yusuflogo.png',width: 160,height: 160,),
                      const SizedBox(height: 50,),
                      MyTextField(
                        controller: name,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15,),
                      MyTextField(
                        controller: password,
                        label: 'Password',
                        obsecureText: true,
                      ),
                      const SizedBox(height: 10,),
                      const Divider(),
                      const SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () {
                          if(loginValidation()){
                  controller.login(name.text,password.text);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ColorPalette.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                height: 40,
                width: double.infinity,
                child: const Center(
                    child: Text('Log in',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    )
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Center(
              child: GestureDetector(
                onTap: () {
                  Get.to(ForgotPasswordScreen());
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.orange,
                      fontSize: 16
                  ),
                ),
              ),
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool loginValidation(){
    if(name.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }
    if
    (password.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Password is required');
      return false;
    }
    // else if
    // (!GetUtils.isEmail(name.text)){
    //   Fluttertoast.showToast(msg: 'Email format is not correct');
    //   return false;
    // }
    else
      return true;
  }
}
