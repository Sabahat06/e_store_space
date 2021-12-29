import 'package:cached_map/cached_map.dart';
import 'package:e_store_space/models/product_model.dart';
import 'package:get/get.dart';


class Cart {
  RxList<Item> items = <Item>[].obs;

  Cart({this.items});

  Cart.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items.value = new List<Item>();
      json['items'].forEach((v) {
        items.add(new Item.fromJson(v));
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

class Item {
  String id;
  RxInt quantity = 0.obs;
  String title;
  String shortDetails;
  String longDetails;
  String salePrice;
  String photo;
  String categoryId;
  String subCategoryId;
  String choiceID;
  String choiceColorName;
  String discountedPrice;
  String discount;

  List<Choices> choices;

  Item(
      {this.id,
        this.quantity,
        this.title,
        this.shortDetails,
        this.longDetails,
        this.salePrice,
        this.photo,
        this.categoryId,
        this.subCategoryId,
        this.choiceID,
        this.choices,
        this.choiceColorName,
        this.discountedPrice,
        this.discount,
      });

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity.value = json['quantity'];
    title = json['title'];
    shortDetails = json['short_details'];
    longDetails = json['long_details'];
    salePrice = json['sale_price'];
    photo = json['photo'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    choiceID = json['choiceID'];
    choiceColorName = json['color_name'];
    discountedPrice = json['discounted_price'];
    discount = json['discount'];

    if (json['choices'] != null) {
      choices = new List<Choices>();
      json['choices'].forEach((v) {
        choices.add(new Choices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity.value;
    data['title'] = this.title;
    data['short_details'] = this.shortDetails;
    data['long_details'] = this.longDetails;
    data['sale_price'] = this.salePrice;
    data['photo'] = this.photo;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['choiceID'] = this.choiceID;
    data['color_name'] = this.choiceColorName;
    data['discounted_price'] = this.discountedPrice;
    data['discount'] = this.discount;
    if (this.choices != null) {
      data['choices'] = this.choices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


