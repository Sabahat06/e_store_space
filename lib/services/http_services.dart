import 'dart:convert';
import 'package:e_store_space/models/add_store_model.dart';
import 'package:e_store_space/models/auth_model.dart';
import 'package:e_store_space/models/get_store_product.dart';
import 'package:e_store_space/models/order_detail_model.dart';
import 'package:e_store_space/models/page.dart';
import 'package:e_store_space/models/product_category_model.dart';
import 'package:e_store_space/models/product_detail.dart';
import 'package:e_store_space/models/user_store.dart';
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
        StaticVariable.loginResponseCode= response.statusCode;
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
        StaticVariable.registerResponseCode = response.statusCode;
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
      ({String token, String name, String email, String phone, String address, String city, String oldPassword, String newPassword}) async {
    Uri _updateProfile = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/seller-update');
    try {
      var response = await http.post(
        _updateProfile,
        headers: {'Authorization': 'Bearer $token'},
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
        StaticVariable.updateProfileResponseCode = response.statusCode;
        return jsonDecode(response.body)['message'];

      } else
        return "Some error accoured";
    }
    catch (e) {
      return "Some error accoured";
    }
  }


  static Future<String> placeOrderForLoginCustomer({String token, String customerID,String country, String phone, String area, String city ,String name,String email,String orderNotes,String address, String amount, List<PlaceOrderDetailModal> orderDetails}) async {
    try {
      Uri _placeOrder = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/addOrder');
      var response1 = await http.post(
        _placeOrder,
        headers: {
          // 'Content-Type': 'application/json',
          // 'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'user_id': customerID,
          'price' : amount,
          'order_notes': orderNotes,
          'shaping_address' : address,
          'product' : jsonEncode(orderDetails),
        },
      );
      if (response1.statusCode == 200 || response1.statusCode == 201) {
        StaticVariable.placeOrderResponseCode = response1.statusCode;
        return jsonDecode(response1.body)['message'];
      } else
        Fluttertoast.showToast(msg: "Your Order is not placed");
    }
    catch (e) {
      print(e);
      return null;
    }
  }


  static Future<UserStore> getUserStore
      ({String token}) async {
    Uri _getUserStore = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/getUserStore');
    try {
      var response = await http.get(
        _getUserStore,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return UserStore.fromJson(jsonDecode(response.body));
      }
    }
    catch (e) {
      return null;
    }
  }


  static Future<AddStoreModel> addUserStore
      ({String token, String name, String dealType, String description}) async {
    Uri _addUserStore = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/addStore');
    try {
      var response = await http.post(
        _addUserStore,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'name': name,
          'deal_type': dealType,
          'description': description
        }
      );
      if (response.statusCode == 201 || response.statusCode == 201) {
        StaticVariable.addUserDealResponseCode= response.statusCode;
        return AddStoreModel.fromJson(jsonDecode(response.body));
      }
    }
    catch (e) {
      return null;
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

  static Future<OrderHistoryModel> getOrderHistory
      ({String token}) async {
    Uri _getOrderHistory = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/getOrderHistory');
    try {
      var response = await http.get(
        _getOrderHistory,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return OrderHistoryModel.fromJson(jsonDecode(response.body));
      }
    }
    catch (e) {
      return null;
    }
  }

  static Future<StoreProductModel> getStoreProducts
      ({String token, String id}) async {
    Uri _storeProduct = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/getStoreProducts/${id}');
    try {
      var response = await http.get(
        _storeProduct,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return StoreProductModel.fromJson(jsonDecode(response.body));
      }
    }
    catch (e) {
      return null;
    }
  }


  static Future<OrderDetailModel> getOrderDetails(
      String orderId, String token) async {
    Uri _uriGetOrderDetails = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/getOrderDetails/${orderId}');
    try {
      var response = await http.get(
        _uriGetOrderDetails,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return OrderDetailModel.fromJson(jsonDecode(response.body));

      } else {
        return null;
      }
    }
    catch (e) {
      return null;
    }
  }


  static Future<OrderDetailModel> addStoreProduct({
      List<SelectedProductSeller> selectedProductSeler, String token, String store_id, String user_id}) async {
    Uri _addStoreProduct = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/addStoreProduct');
    try {
      var response = await http.post(
        _addStoreProduct,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'store_id' : store_id,
          'product' : jsonEncode(selectedProductSeler)
        }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        StaticVariable.addStoreResponseCode = response.statusCode;
        return OrderDetailModel.fromJson(jsonDecode(response.body));

      } else {
        return null;
      }
    }
    catch (e) {
      return null;
    }
  }

  static Future<String> becameASeller
      ({String token, String name, String email, String phone, String message, String refrence_promo_code,}) async {
    Uri _updateProfile = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/becomeASeller');
    try {
      var response = await http.post(
        _updateProfile,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'name': name,
          'email': email,
          'phone_no': phone,
          'message': message,
          'refrance_promo_code': refrence_promo_code,
        },
      );
      if (response.statusCode == 201 || response.statusCode == 201) {
        StaticVariable.becameASellerResponseCode = response.statusCode;
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




