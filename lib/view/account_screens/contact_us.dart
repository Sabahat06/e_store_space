import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/settings/color_palates.dart';
import 'package:e_store_space/widgets/my_filled_button.dart';
import 'package:e_store_space/widgets/my_text_field.dart';

class ContactUs extends StatelessWidget {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();

  RxBool progressing = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Contact Us', style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
            () =>
        progressing.value ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [

                Image.asset('assets/image/yusuflogo.png',width: 150,height: 150,),

                SizedBox(height: 10,),
                MyTextField(controller: name, label: 'Enter Full Name'),
                SizedBox(height: 10,),
                MyTextField(controller: email, label: 'Enter Email'),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(width: 2,),
                    Expanded(
                      child: MyTextField(
                        height: 64,
                        maxLength: 11,
                        controller: phone,
                        label: 'Enter Phone No.',
                        keyboardType: TextInputType.number,

                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                MyTextField(controller: subject, label: 'Enter Subject'),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.17,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorPalette.orange),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    controller: message,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Enter Message',
                      hintStyle: TextStyle(color: ColorPalette.orange),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                MyFilledButton(
                  ontap: () async {
                    if(contactUsValidation()){
                      progressing.value = true;
                      String response = await HttpService.contactUs(
                          phone: phone.text,
                          email: email.text,
                          name: name.text,
                          message: message.text,
                          subject: subject.text
                      );
                      progressing.value = false;
                      Fluttertoast.showToast(msg: response);
                      Get.back();
                    }
                  },
                  color: ColorPalette.orange,
                  width: double.infinity,
                  height: 40,
                  borderRadius: 0,
                  txt: 'Send Message',
                ),
                SizedBox(height: 10,),

                Row(
                  children: [
                    Text('Get in Touch', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(height: 3,),
                Text('Get in touch with our customer support team. You can leave a message here directly by filling and submitting this form. Thank You.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.4),
                  textAlign: TextAlign.values[3],
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
