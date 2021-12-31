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

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: const Text('Sign In', style: TextStyle(color: Colors.white),),
      ),
      body: Obx(
        () => controller.progressing.value ? Center(child: CircularProgressIndicator(),) :
        SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20,),
                  Image.asset('assets/image/appimage.jpeg',width: 200,height: 200,),
                  const SizedBox(height: 5,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text('Log In to your Account', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  MyTextField(
                    prefixIcon: IconButton(icon: Icon(Icons.email_outlined, color: Colors.blue,)),
                    controller: email,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15,),
                  MyTextField(
                    prefixIcon: IconButton(icon: Icon(Icons.lock_outlined, color: Colors.blue,)),
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
                    controller.login(email.text,password.text);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 40,
                    width: double.infinity,
                    child: const Center(
                      child: Text('Log in',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
                Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(ForgotPasswordScreen());
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 18
                    ),
                  ),
                ),
              ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool loginValidation(){
    if(email.text.trim().length==0){
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
