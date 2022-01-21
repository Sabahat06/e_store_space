import 'dart:ui';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/controller/cart/shop_cart_screen_controller.dart';
import 'package:e_store_space/models/place_order_detail_modal.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/statics/static_var.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/dummy_order_controller.dart';
import 'package:e_store_space/controller/place_order_login_controler.dart';
import 'package:e_store_space/view/homepage.dart';
import 'package:e_store_space/widgets/my_text_field.dart';
import 'dart:io' show Platform;


class AddOrderLoginScreen extends StatelessWidget {
  AuthController authController = Get.find();
  CartControllerNew cartController = Get.find();
  BottomBarController bottomBarController = Get.find();
  PlaceOrderLoginController controller = Get.put(PlaceOrderLoginController());
  String totalAmount;

  TextEditingController addressController;
  TextEditingController messageController = TextEditingController();
  TextEditingController name;
  TextEditingController email;
  TextEditingController address;
  TextEditingController area = TextEditingController();
  TextEditingController phone;
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  AddOrderLoginScreen({this.totalAmount}){
    name = TextEditingController(text: authController.user.value.user.name);
    email = TextEditingController(text: authController.user.value.user.email);
    address = TextEditingController(text: authController.user.value.user.address);
    phone = TextEditingController(text: authController.user.value.user.phoneNo);
    city = TextEditingController(text: authController.user.value.user.city);
    // area = TextEditingController(text: authController.user.value.user.area);
    // country = TextEditingController(text: authController.user.value.user.country);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: const Text('Checkout', style: TextStyle(color: Colors.white),),
      ),
      body: Obx(
        () => controller.progressing.value
            ? Center(child: CircularProgressIndicator())
            : Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 7),
                        MyTextField(
                          prefixIcon: IconButton(icon: Icon(Icons.person_outlined, color: Colors.blue,)),
                          controller: name,
                          label: 'Name',
                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          prefixIcon: IconButton(icon: Icon(Icons.email_outlined, color: Colors.blue,)),
                          controller: email,
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          prefixIcon: IconButton(icon: Icon(Icons.phone_outlined, color: Colors.blue,)),
                          controller: phone,
                          label: 'Phone Number',
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          minLines: 2,
                          // any number you need (It works as the rows for the textarea)
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: address,
                          decoration: const InputDecoration(
                            prefixIcon: IconButton(icon: Icon(Icons.home_outlined, color: Colors.blue,)),
                            fillColor: Colors.blue,
                            focusColor: Colors.blue,
                            hoverColor: Colors.blue,
                            labelText: 'Address',
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
                        MyTextField(
                          prefixIcon: IconButton(icon: Icon(Icons.home_outlined, color: Colors.blue,)),
                          controller: area,
                          label: 'Area',
                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          prefixIcon: IconButton(icon: Icon(Icons.location_city_outlined, color: Colors.blue,)),
                          controller: city,
                          label: 'City',
                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          prefixIcon: IconButton(icon: Icon(Icons.location_city_outlined, color: Colors.blue,)),
                          controller: country,
                          label: 'Country',
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          minLines: 3,
                          // any number you need (It works as the rows for the textarea)
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: messageController,
                          decoration: const InputDecoration(
                            prefixIcon: IconButton(icon: Icon(Icons.message_outlined, color: Colors.blue,)),
                            fillColor: Colors.blue,
                            focusColor: Colors.blue,
                            hoverColor: Colors.blue,
                            labelText: 'Order Notes',
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
                        const SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue)
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Amount', style: TextStyle(fontSize: 16.sp),),
                              Text(totalAmount, style: TextStyle(fontSize: 16.sp, color: Colors.blue),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: GestureDetector(
                    onTap: () async {
                      if(placeOrderValidation()){
                        List<PlaceOrderDetailModal> orderDetails = [];
                        if(cartController.items.length>0)
                        {
                          cartController.items.forEach((product) {
                            orderDetails.add(PlaceOrderDetailModal(
                                product_id: product.id.toString(),
                                quantity: product.quantity.value.toString(),
                                color_id: product.choiceID,
                                price: product.price.toString(),
                                discount: "0"
                            ));
                          });
                        }
                        controller.progressing.value = true;
                        var response = await HttpService.placeOrderForLoginCustomer(
                          token: authController.user.value.token,
                          customerID: authController.user.value.user.id.toString(),
                          amount: totalAmount,
                          name: name.text,
                          email: email.text,
                          phone: phone.text,
                          address: address.text,
                          area: area.text,
                          city: city.text,
                          country: country.text,
                          orderDetails: orderDetails,
                          orderNotes: messageController.text,
                        );
                        controller.progressing.value = false;
                        if(StaticVariable.placeOrderResponseCode==200){
                          Fluttertoast.showToast(msg: "Your Order has been Placed Successfully");
                          cartController.clearCart();
                          bottomBarController.currentBNBIndex.value = 0;
                          Get.off(() => HomePage());
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.blue,
                      ),
                      height: 45,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('CONFIRM ORDER', style: TextStyle(color: Colors.white, fontSize: 20),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Platform.isIOS ? const SizedBox(height: 10,) : Container()
              ],
            ),
          ),
      ),

    );
  }

  bool placeOrderValidation(){
    if(name.text.trim().length<=5){
      Fluttertoast.showToast(msg: 'The name must be at least 5 characters');
      return false;
    }else if
    (!GetUtils.isEmail(email.text)){
      Fluttertoast.showToast(msg: 'Email format is not correct');
      return false;
    }
    else if
    (email.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }
    else if
    (phone.text.trim().length < 11){
      Fluttertoast.showToast(msg: 'Enter Valid Phone Number');
      return false;
    }
    else if
    (address.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Address is required');
      return false;
    }else if
    (city.text.trim().length==0){
      Fluttertoast.showToast(msg: 'City is required');
      return false;
    }else if
    (area.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Area is required');
      return false;
    }else if
    (country.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Country is required');
      return false;
    }
    else
      return true;
  }

}
