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
  int id;
  RxInt quantity = 0.obs;
  String userId;
  String categoryId;
  String name;
  String description;
  String price;
  String picture;
  String choiceID;
  String createdAt="";
  String updatedAt="";
  String deletedAt='';
  List<ProductColorsCart> productColors;

  Item(
      {this.id,
        this.userId,
        this.categoryId,
        this.name,
        this.description,
        this.price,
        this.picture,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.productColors,
        this.quantity,
        this.choiceID
      });

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    picture = json['picture'];
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
    deletedAt = json['deleted_at']??"";
    quantity.value = json['quantity']??0;
    if (json['product_colors'] != null) {
      productColors = <ProductColorsCart>[];
      json['product_colors'].forEach((v) {
        productColors.add(new ProductColorsCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['picture'] = this.picture;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['quantity'] = this.quantity.value;
    if (this.productColors != null) {
      data['product_colors'] =
          this.productColors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class ProductColorsCart {
  int id;
  String productId;
  String colorId;
  String quantity;
  String image;
  String createdAt="";
  String updatedAt="";
  String deletedAt='';

  ProductColorsCart(
      {this.id,
        this.productId,
        this.colorId,
        this.quantity,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
      });

  ProductColorsCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    colorId = json['color_id'];
    quantity = json['quantity'];
    image = json['image'];
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
    deletedAt = json['deleted_at']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['color_id'] = this.colorId;
    data['quantity'] = this.quantity;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}


