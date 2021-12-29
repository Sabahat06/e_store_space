import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/cart_controller.dart';
import 'package:e_store_space/models/ForgotPassword.dart';
import 'package:e_store_space/models/auth_model.dart';
import 'package:e_store_space/models/category_model.dart';
import 'package:e_store_space/models/dashboard.dart';
import 'package:e_store_space/models/faq_model.dart';
import 'package:e_store_space/models/html_content.dart';
import 'package:e_store_space/models/order_history_model.dart';
import 'package:e_store_space/models/place_order_detail_modal.dart';
import 'package:e_store_space/models/product_model.dart';
import 'package:e_store_space/models/search.dart';
import 'package:e_store_space/models/send_request_model.dart';
import 'package:e_store_space/models/time_slot.dart';
import 'package:e_store_space/models/used_mobile_model.dart';
import 'package:e_store_space/statics/static_var.dart';
import 'package:fluttertoast/fluttertoast.dart';


class HttpService {
  AuthController authController= Get.find();


  static Uri _uri = Uri.parse("https://imrans15.sg-host.com/app/app.php");
  static String _url = "https://imrans15.sg-host.com/app/app.php";

  static Future<List<CategoryModel>> getAllCategories() async {
    try {
      var response = await http.post(
        _uri,
        body: {'get_all_categories': '1'},
      );
      if (response.statusCode == 200) {
        List rawList = jsonDecode(response.body);
        return rawList.map((json) => CategoryModel.fromJson(json)).toList();
      } else
        return null;
    }
    catch (e) {
      print(e);
      return null;
    }
  }


  static Future<http.Response> post({
    @required dynamic body,
  }) async {
    var response = await  http.post(
      Uri.parse(_url),
      body: body,
    );
    if(response.statusCode==503)
    {
      _url = '';

      return http.post(
        Uri.parse(_url),
        body: body,
      );
    }
    else
      return response;
  }


  static Future<AuthResponse> registerUser
      ({String name,String email,String phone, String password,String address,String city, String shopName, String shopPhoto}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'register_account': '1',
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'address': address,
          'city': city,
          'shop_name': shopName,
          'shop_photo': shopPhoto
        },
      );
      if (response.statusCode == 200) {
        return AuthResponse.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<AuthResponse> loginUser
      (String email,String password) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'user_login': '1',
          'username': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        return AuthResponse.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<ForgotPasswordResponse> forgotPassword
      (String email) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'forgot_email': email,
        },
      );
      if (response.statusCode == 200) {
        return ForgotPasswordResponse.fromJson(jsonDecode(response.body));
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<SendRequestResponse> sendRequest
       (String customerId, String subject, String description) async {
    try {
      var response = await http.post(
        _uri,
        body: {

          'new_request': '1',
          'customer_id': customerId,
          'subject': subject,
          'description': description,
        },
      );
      if (response.statusCode == 200) {
        // return SendRequestResponse.fromJson(jsonDecode(response.body));
        return SendRequestResponse.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }


  static Future<dynamic> updateProfile
      ({String customerId, String name, String email, String phone, String address,String shopName,String shopPhoto, String city,String oldPassword, bool updatePassword, String newPassword}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'update_profile': '1',
          'customer_id': customerId,
          'name': name,
          'email': email,
          'rating': phone,
          'address': address,
          'shop_name': shopName,
          'shop_photo': shopPhoto,
          'city': city,
          'update_password': updatePassword?'1':'0',
          'old_password': updatePassword?oldPassword:"",
          'new_password': updatePassword?newPassword:"",
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      else
        return null;
    }
    catch (e) {
      return null;
    }
  }


  static Future<ProductModel> getProductsOfSubCategory(
      String subCategoryID,int pageNo) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'sub_category_products': '1',
          'sub_category_id': subCategoryID,
          'page_no': pageNo.toString()
        },
      );
      if (response.statusCode == 200) {
        return ProductModel.fromJson(jsonDecode(response.body)) ;

      } else {
        return null;
      }
    }
    catch (e) {
      return null;
    }
  }


  ///Order API///

  static Future<dynamic> placeOrderForLoginCustomer({String customerID,String deliveryDate,String slotId,String orderNotes,String billingAddress, String amount, List<PlaceOrderDetailModal> orderDetails}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'new_order': '1',
          'customer_type' : 'login',
          'customer_id' : customerID,
          'delivery_date' : deliveryDate,
          'slot_id' : slotId,
          'order_notes' : orderNotes ?? "",
          'billing_address' : billingAddress,
          'amount' : amount,
          'order_details' : jsonEncode(orderDetails),
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else
        return null;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  static Future<UsedMobileModel> getUsedMobile(String customerId, int pageno) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'used_mobiles': '1',
          'page_no': pageno.toString(),
          'customer_id':customerId ,

        },
      );
      if (response.statusCode == 200) {
        return UsedMobileModel.fromJson(jsonDecode(response.body));
      } else
        return null;
    }
    catch (e) {
      print(e);
      return null;
    }
  }


  static Future<List<TimeSlotModel>> getTimeSlots() async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'get_timeslots': '1'
        },
      );
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        return jsonList.map((json) => TimeSlotModel.fromJson(json)).toList();
      } else
        return null;
    }
    catch (e) {
      print(e);
      return null;
    }
  }




  static Future<dynamic> addLoggedInUserMobile({String customerId,String mobileName, String description, String price,String image}) async {

    try {
          var response = await http.post(
        _uri,
        body: {
          'add_used_mobile': '1',
          'customer_id' : customerId ,
          'mobile_name' : mobileName,
          'description' : description,
          'mobile_price' : price,
          'mobile_photo' : image,

        },
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: jsonDecode(response.body)["msg"]);
        return jsonDecode(response.body);
      } else
        return null;
    }
    catch (e) {
      // StaticVariable.isLoading=false;
      print(e);
      return null;
    }
  }


  static Future<dynamic> deleteMyUsedMobile({String id}) async {

    try {
      var response = await http.post(
        _uri,
        body: {
          'delete_used_mobile': '1',
          'id' : id ,

        },
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: jsonDecode(response.body)["msg"]);
        return jsonDecode(response.body);
      } else
        return null;
    }
    catch (e) {
      // StaticVariable.isLoading=false;
      print(e);
      return null;
    }
  }


  static Future<Orders> getOrderWithID
      (String orderId) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'view_order': '1',
          'order_id': orderId,
        },
      );
      if (response.statusCode == 200) {
        return Orders.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }


  static Future<List<Faq>> getFaqs
      () async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'faqs': '1',
        },
      );
      if (response.statusCode == 200) {
        List rawList = jsonDecode(response.body);
        return rawList.map((json) => Faq.fromJson(json)).toList();
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }


  static Future<DashBoard> getDashboard
      (String customerId) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'customer_dashboard': '1',
          'customer_id': customerId,
        },
      );
      if (response.statusCode == 200) {
        return DashBoard.fromJson(jsonDecode(response.body));
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }


  static Future<HtmlContent> htmlContent
      (String page_id) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'html_content': '1',
          'page_id': page_id,
        },
      );
      if (response.statusCode == 200) {
        return HtmlContent.fromJson(jsonDecode(response.body)['data']);
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  ///---------------------------------------------FCM Integrations-----------------------------------------------///

  static Future<String> createToken
      (String userID,String deviceID,String token) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'create_token': '1',
          'user_id' : userID,
          'device_id' : deviceID,
          'type' : '0',
          'token' : token
        },
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['msg']);
        return jsonDecode(response.body)['status'];

      } else
        return "";
    }
    catch (e) {
      return "";
    }
  }




  static Future<String> updateToken
      (String deviceID,String token) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'update_token': '1',
          'device_id' : deviceID,
          'type' : '0',
          'token' : token
        },
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['msg']);
        return jsonDecode(response.body)['status'];

      } else
        return "";
    }
    catch (e) {
      return "";
    }
  }




  static Future<String> deleteToken
      (String deviceID) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'delete_token': '1',
          'device_id' : deviceID,
          'type' : '0',
        },
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['msg']);
        return jsonDecode(response.body)['status'];

      } else
        return "";
    }
    catch (e) {
      return "";
    }
  }

  static Future<OrderHistoryModal> getOrdersHistory
      ({String customerId,int pageNo}) async {
    print("CustomerID: $customerId");
    try {
      var response = await http.post(
        _uri,
        body: {
          'order_history': '1',
          'customer_id': customerId,
          'page_no' : pageNo.toString(),
          // 'page_no' : '1',
        },
      );
      if (response.statusCode == 200) {
        return OrderHistoryModal.fromJson(jsonDecode(response.body));


      } else {
        return null;
      }
    }
    catch (e) {
      return null;
    }
  }

  static Future<String> cancelOrder
      ({String orderId}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'cancel_order': '1',
          'order_id': orderId,
        },
      );
      if (response.statusCode == 200) {
        // Utils.showToast(jsonDecode(response.body)['msg']);
        Fluttertoast.showToast(msg: jsonDecode(response.body)['msg']);
        return jsonDecode(response.body)['status'];
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }


  static Future<String> contactUs
      ({String name, String email, String phone, String subject, String message}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'contact_us': '1',
          'name': name,
          'email': email,
          'phone': phone,
          'subject': subject,
          'message': message
        },
      );
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status']==0){
          Fluttertoast.showToast(msg: jsonDecode(response.body)['status']);
        }
        return jsonDecode(response.body)['msg'];

      } else
        return "Some error accoured";
    }
    catch (e) {
      return "Some error accoured";
    }
  }



  static Future<dynamic> getAppSettings({String userID}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'get_settings': '1',
          'user_id' : userID ?? "0"
        },
      );
      if (response.statusCode == 200) {
        StaticVariable.deliveryCharges= jsonDecode(response.body)['product_delivery'];
        StaticVariable.initial_slide_1= jsonDecode(response.body)['initial_slide_1'];
        StaticVariable.initial_slide_2= jsonDecode(response.body)['initial_slide_2'];
        StaticVariable.initial_slide_3= jsonDecode(response.body)['initial_slide_3'];
        StaticVariable.user_status.value = jsonDecode(response.body)['user_status'] ?? "";
        StaticVariable.account_status.value = jsonDecode(response.body)['account_status'] ?? "";
        StaticVariable.appSettings.value = true;
        return jsonDecode(response.body);

      } else
        return "Some error accoured";
    }
    catch (e) {
      return "Some error accoured";
    }
  }


  static Future<List<SearchProduct>> searchProduct
      (String searchString) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'search_string': searchString,
        },
      );
      if (response.statusCode == 200) {
        List rawList = jsonDecode(response.body)['products'];
        return rawList.map((json) => SearchProduct.fromJson(json)).toList();

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

}




