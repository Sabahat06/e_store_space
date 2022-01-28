import 'dart:convert';
import 'dart:io';
import 'package:e_store_space/models/add_store_model.dart';
import 'package:e_store_space/models/auth_model.dart';
import 'package:e_store_space/models/get_store_product.dart';
import 'package:e_store_space/models/latest_store_model.dart';
import 'package:e_store_space/models/order_detail_model.dart';
import 'package:e_store_space/models/page.dart';
import 'package:e_store_space/models/product_category_model.dart';
import 'package:e_store_space/models/product_detail.dart';
import 'package:e_store_space/models/sold_product_model.dart';
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


  static Future<LatestAndStoreModel> getAllStore() async {
    Uri _getStore = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/getAllStore');
    try {
      var response = await http.get(
        _getStore,
      );
      if (response.statusCode == 200) {
        return LatestAndStoreModel.fromJson(jsonDecode(response.body));
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

  static Future<ProductModel> getProductOfStore(
      String storeID,) async {
    Uri _uriStoreOfProduct = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/getStoreProductId/${storeID}');
    try {
      var response = await http.get(
        _uriStoreOfProduct,
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
      if (response.statusCode == 200 || response.statusCode == 200) {
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
      if (response.statusCode == 201 || response.statusCode == 200) {
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
      if (response.statusCode == 201 || response.statusCode == 200) {
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
      if (response.statusCode == 201 || response.statusCode == 200) {
        StaticVariable.updateProfileResponseCode = response.statusCode;
        return jsonDecode(response.body)['message'];

      } else
        return "Some error accoured";
    }
    catch (e) {
      return "Some error accoured";
    }
  }


  static Future<String> placeOrderForLoginCustomer({int i, String discount, String token1, String customerID,String country, String phone, String area, String city ,String name,String email,String orderNotes,String address, String amount, String productId, String colorId, String productPrice, String quantity}) async {
    try {
      Uri _placeOrder = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/addOrder');
      var response1 = await http.post(
        _placeOrder,
        headers: {'Authorization': 'Bearer $token1'},
        body: {
          'user_id': customerID,
          'order_notes': orderNotes,
          "store_id" : "1",
          'price' : amount,
          'shaping_address' : address,
          'product[i][product_id]' : productId,
          'product[i][color_id]' : colorId,
          'product[i][price]' : productPrice,
          'product[i][discount]' : discount,
          'product[i][quantity]' : quantity,
        },
      );
      if (response1.statusCode == 200 || response1.statusCode == 201) {
        StaticVariable.placeOrderResponseCode = response1.statusCode;
        return jsonDecode(response1.body)['message'];
      } else
        print(response1);
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

  static Future<String> forgotPassword
      ({String email}) async {
    Uri _forgotPassword = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/password/${email}');
    try {
      var response = await http.get(
        _forgotPassword,
      );
      if (response.statusCode == 200||response.statusCode == 201) {
        Fluttertoast.showToast(msg: "Password has been send to your mail Thanku");
        return (response.body);
      }
      else{
        Fluttertoast.showToast(msg: "Enter Email is Invalid");
      }
    }
    catch (e) {
      return null;
    }
  }

  static Future<AddStoreModel> addUserStore
      ({String token, String name, String dealType, String description, File file}) async {
    Uri _addUserStore = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/addStore');
    try {
      Map<String, String> headers = { "Authorization": 'Bearer $token'};
      http.MultipartRequest request = new http.MultipartRequest("POST", _addUserStore);
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath('image', file.path);
      request.headers.addAll(headers);
      request.fields['name'] = name;
      request.fields['deal_type'] = dealType;
      request.fields['description'] = name;
      request.files.add(multipartFile);
      http.StreamedResponse response = await request.send();
      print(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        StaticVariable.addUserDealResponseCode= response.statusCode;
        // return AddStoreModel.fromJson(jsonDecode());
      }

      // var response = await http.post(
      //   _addUserStore,
      //   headers: {'Authorization': 'Bearer $token'},
      //   body: {
      //     'name': name,
      //     'deal_type': dealType,
      //     'description': description,
      //     'image': file,
      //   }
      // );
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   StaticVariable.addUserDealResponseCode= response.statusCode;
      //   return AddStoreModel.fromJson(jsonDecode(response.body));
      // }
    }
    catch (e) {
      return null;
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


  static Future<String> addStoreProduct({
      List<SelectedProductSeller> selectedProductSeler, String token, String store_id, String user_id}) async {
    Uri _addStoreProduct = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/addStoreProduct');
    try {

      // Map<String, String> headers = { "Authorization": 'Bearer $token'};
      // http.MultipartRequest request = new http.MultipartRequest("POST", _addStoreProduct);
      // // http.MultipartFile multipartFile = await http.MultipartFile.fromPath('image', file.path);
      // request.headers.addAll(headers);
      // request.fields['store_id'] = store_id;
      // request.fields['product'] = jsonEncode(selectedProductSeler);
      // // request.files.add(multipartFile);
      // http.StreamedResponse response = await request.send();
      // print(response);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   StaticVariable.addStoreProductResponseCode= response.statusCode;
      //   // return AddStoreModel.fromJson(jsonDecode());
      // }

      var response = await http.post(
        _addStoreProduct,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'store_id' : store_id,
          'product' : jsonEncode(selectedProductSeler)
        }
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        StaticVariable.addStoreProductResponseCode = response.statusCode;
        return jsonDecode(response.body)['productStore'];

      } else {
        return null;
      }
    }
    catch (e) {
      return null;
    }
  }

  static Future<SoldProductModel> getSoldProduct
      ({String token}) async {
    Uri _getSoldProduct = Uri.parse('https://spinningsoft.co/projects/eStoreSpace/api/getSellerSoldProduct');
    try {
      var response = await http.get(
        _getSoldProduct,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return SoldProductModel.fromJson(jsonDecode(response.body));
      }
    }
    catch (e) {
      return null;
    }
  }

  static Future<String> becameASeller
      ({String token, String name, String email, String phone, String message, String refrence_promo_code, String role}) async {
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
          'role' : role
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
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




