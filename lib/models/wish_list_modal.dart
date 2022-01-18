
import 'package:e_store_space/models/product_detail.dart';

class WishList {
  List<ProductDetailsModel> items;

  WishList({this.items});

  WishList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<ProductDetailsModel>();
      json['items'].forEach((v) {
        items.add(new ProductDetailsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}