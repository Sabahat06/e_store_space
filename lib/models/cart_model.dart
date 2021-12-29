
import 'package:get/get.dart';
import 'package:e_store_space/models/product_model.dart';




class Cart {
  RxList<Products> products = <Products>[].obs;
  Cart({this.products});

  Cart.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products= <Products>[].obs;
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}