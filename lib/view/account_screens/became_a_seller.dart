import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/models/auth_model.dart';
import 'package:e_store_space/statics/static_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/settings/color_palates.dart';
import 'package:e_store_space/widgets/my_filled_button.dart';
import 'package:e_store_space/widgets/my_text_field.dart';

class BecomeASeller extends StatelessWidget {
  AuthController authController = Get.find();

  TextEditingController name ;
  TextEditingController email;
  TextEditingController phone;
  TextEditingController promoCode = TextEditingController();
  TextEditingController message = TextEditingController();
  TextEditingController type = TextEditingController();

  BecomeASeller(){
    name = TextEditingController(text: authController.user.value.user.name);
    email = TextEditingController(text: authController.user.value.user.email);
    phone = TextEditingController(text: authController.user.value.user.phoneNo);
  }

  List<String> userTypeValue = ['Seller', "Affiliate"];

  RxBool progressing = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: const Text('Became a Seller', style: TextStyle(color: Colors.white),),
      ),
      body: Obx(
            () =>
        progressing.value ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Image.asset('assets/image/appimage.jpeg',width: 150,height: 150,),
                SizedBox(height: 10.h,),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    MyTextField(
                      controller: type,
                      label: "User Type",
                      enabled: false,
                    ),
                    DropdownButton<String>(
                      isExpanded: true,
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 3.0),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                        ),
                      ),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.blue),
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      onChanged: (newValue) {
                        type.text = newValue;
                        // controller.selectedColony= controller.colonies.firstWhere((element) => element.name == colony.text);
                      },
                      items: <String>['Seller', 'Affiliate']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ]
                ),
                SizedBox(height: 10.h,),
                MyTextField(controller: promoCode, label: 'Enter Promo Code', prefixIcon: const IconButton(icon: Icon(Icons.code_outlined, color: Colors.blue,),),),
                SizedBox(height: 10.h,),
                MyTextField(controller: name, label: 'Enter Full Name', prefixIcon: const IconButton(icon: Icon(Icons.person_outlined, color: Colors.blue,),),),
                SizedBox(height: 10.h,),
                MyTextField(controller: email, label: 'Enter Email', prefixIcon: const IconButton(icon: Icon(Icons.email_outlined, color: Colors.blue,),),),
                SizedBox(height: 10.h,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 2.w,),
                    Expanded(
                      child: MyTextField(
                        prefixIcon: IconButton(icon: Icon(Icons.phone_outlined, color: Colors.blue,),),
                        height: 64,
                        maxLength: 11,
                        controller: phone,
                        label: 'Enter Phone No.',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h,),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.17,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    controller: message,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Enter Message',
                      prefixIcon: IconButton(icon: Icon(Icons.message_outlined, color: Colors.blue,)),
                      hintStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h,),
                MyFilledButton(
                  ontap: () async {
                    if(becameASellerValidation()){
                      progressing.value = true;
                      String response = await HttpService.becameASeller(
                          token: authController.user.value.token,
                          phone: phone.text,
                          email: email.text,
                          name: name.text,
                          message: message.text,
                          refrence_promo_code: promoCode.text,
                          role: type.text
                      );
                      progressing.value = false;
                      if(StaticVariable.becameASellerResponseCode == 200 || StaticVariable.becameASellerResponseCode == 201){
                        if(type.text == "Affiliate"){
                          authController.user.value.user.affiliate.value = "1";
                          User.saveUserToCache(authController.user.value);
                          Fluttertoast.showToast(msg: "Now you are a Affiliate");
                          Get.back();
                        }
                        else if (type.text == "Seller"){
                          authController.user.value.user.seller.value = "1";
                          User.saveUserToCache(authController.user.value);
                          Fluttertoast.showToast(msg: "Now you are a Affiliate");
                          Get.back();
                        }
                      }
                      else{
                        Fluttertoast.showToast(msg: "Invalid data");
                      }
                    }
                  },
                  color: Colors.blue,
                  width: double.infinity,
                  height: 40,
                  borderRadius: 0,
                  txt: 'Submit',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool becameASellerValidation(){
    if(name.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Name is Required');
      return false;
    }
    else if
    (!GetUtils.isEmail(email.text)){
      Fluttertoast.showToast(msg: 'Email format is not correct');
      return false;
    }
    else if
    (email.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is Required');
      return false;
    }
    else if (phone.text.trim().length == 0){
      Fluttertoast.showToast(msg: 'Phone Number is required');
      return false;
    }
    else if (type.text.trim().length == 0){
      Fluttertoast.showToast(msg: 'User Type is required');
      return false;
    }
    else if (promoCode.text.trim().length == 0){
      Fluttertoast.showToast(msg: 'Promo Code is required');
      return false;
    }
    else
      return true;
  }
}
