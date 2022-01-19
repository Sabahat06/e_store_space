import 'dart:convert';
import 'package:e_store_space/models/auth_model.dart';
import 'package:e_store_space/models/page.dart';
import 'package:e_store_space/models/product_category_model.dart';
import 'package:e_store_space/models/product_detail.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:e_store_space/controller/auth_controller.dart';
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

  static Future<HtmlPageModel> getAllPages() async {
    Uri _uriPage = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/getPages');
    try {
      var response = await http.get(
        _uriPage,
      );
      if (response.statusCode == 200) {
        // List rawList = jsonDecode(response.body);
        return HtmlPageModel.fromJson(jsonDecode(response.body));
      } else
        return null;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  static Future<ProductCategory> getProductCategories() async {
    Uri _uriProductCategory = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/getAlLCategory');
    try {
      var response = await http.get(
        _uriProductCategory,
      );
      if (response.statusCode == 200) {
        // List rawList = jsonDecode(response.body);
        return ProductCategory.fromJson(jsonDecode(response.body));
      } else
        return null;
    }
    catch (e) {
      print(e);
      return null;
    }
  }


  static Future<ProductModel> getProductsOfCategory(
      String subCategoryID,) async {
    Uri _uriCategoryProduct = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/getAllProductCategory/${subCategoryID}');
    try {
      var response = await http.get(
        _uriCategoryProduct,
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

  static Future<ProductDetailsModel> getProductDetails(
      String productId,) async {
    Uri _uriGetProductDetails = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/getProductDetails/${productId}');
    try {
      var response = await http.get(
        _uriGetProductDetails,
      );
      if (response.statusCode == 200) {
        return ProductDetailsModel.fromJson(jsonDecode(response.body)) ;

      } else {
        return null;
      }
    }
    catch (e) {
      return null;
    }
  }


  static Future<AuthResponse> loginUser(
      String email, String password,) async {
    Uri _uriGetProductDetails = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/seller-login');
    try {
      var response = await http.post(
        _uriGetProductDetails,
        body: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        return AuthResponse.fromJson(jsonDecode(response.body)) ;

      } else {
        return null;
      }
    }
    catch (e) {
      return null;
    }
  }

  static Future<AuthResponse> registerUser({
      String name, String email, String address, String city, String password, String phoneNumber}) async {
    Uri _uriGetProductDetails = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/seller-registration');
    try {
      var response = await http.post(
        _uriGetProductDetails,
        body: {
          'name' : name,
          'email': email,
          'address': address,
          'password': password,
          'city': city,
          'phone no' : phoneNumber

        },
      );
      if (response.statusCode == 201) {
        return AuthResponse.fromJson(jsonDecode(response.body)) ;

      } else {
        return null;
      }
    }
    catch (e) {
      return null;
    }
  }


  static Future<String> contactUs
      ({String name, String email, String phone, String subject, String message}) async {
    Uri _uriContactUs = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/addContactUs');
    try {
      var response = await http.post(
        _uriContactUs,
        body: {
          'name': name,
          'email': email,
          'phone no': phone,
          'subject': subject,
          'message': message
        },
      );
      if (response.statusCode == 201) {
        return jsonDecode(response.body)['message'];

      } else
        return "Some error accoured";
    }
    catch (e) {
      return "Some error accoured";
    }
  }


  static Future<String> updateProfile
      ({String name, String email, String phone, String address, String city, String oldPassword, String newPassword}) async {
    Uri _uriContactUs = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/seller-update');
    try {
      var response = await http.post(
        _uriContactUs,
        body: {
          'name': name,
          'email': email,
          'phone_no': phone,
          'address': address,
          'city': city,
          'password': oldPassword,
          'password_confirmation': newPassword
        },
      );
      if (response.statusCode == 201) {
        return jsonDecode(response.body)['message'];

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




