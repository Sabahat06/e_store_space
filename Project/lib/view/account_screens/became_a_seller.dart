import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/settings/color_palates.dart';
import 'package:e_store_space/widgets/my_filled_button.dart';
import 'package:e_store_space/widgets/my_text_field.dart';

class BecomeASeller extends StatelessWidget {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController promoCode = TextEditingController();
  TextEditingController message = TextEditingController();

  RxBool progressing = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    // if(contactUsValidation()){
                    //   progressing.value = true;
                    //   String response = await HttpService.contactUs(
                    //       phone: phone.text,
                    //       email: email.text,
                    //       name: name.text,
                    //       message: message.text,
                    //       subject: subject.text
                    //   );
                    //   progressing.value = false;
                    //   Fluttertoast.showToast(msg: response);
                    //   Get.back();
                    // }
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

  bool contactUsValidation(){
    if(name.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Name is Required');
      return false;
    }
    // else if
    // (!GetUtils.isEmail(email.text)){
    //   Fluttertoast.showToast(msg: 'Email format is not correct');
    //   return false;
    // }
    // else if
    // (email.text.trim().length==0){
    //   Utils.showToast('Email is Required');
    //   return false;
    // }
    else if (phone.text.trim().length == 0){
      Fluttertoast.showToast(msg: 'Phone Number is required');
      return false;
    }
    else if (phone.text.trim().length <= 9){
      Fluttertoast.showToast(msg: 'Enter Valid Phone Number');
      return false;
    }
    else
      return true;
  }
}
