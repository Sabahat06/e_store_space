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
  String userId;
  RxInt quantity=0.obs;
  String categoryId;
  String name;
  String description;
  String price;
  String picture;
  String createdAt="";
  String updatedAt="";
  String deletedAt='';
  List<ProductColorsCart> productColors;
  List<RatingsCart> ratings;
  String choiceID;
  String storeID;

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
        this.ratings,
        this.quantity,
        this.choiceID,
        this.storeID
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
    storeID = json["store_id"];
    if (json['product_colors'] != null) {
      productColors = <ProductColorsCart>[];
      json['product_colors'].forEach((v) {
        productColors.add(new ProductColorsCart.fromJson(v));
      });
    }
    if (json['ratings'] != null) {
      ratings = <RatingsCart>[];
      json['ratings'].forEach((v) {
        ratings.add(new RatingsCart.fromJson(v));
      });
    }
    choiceID = json['choice_id']??"";
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
    data['store_id'] = this.storeID;
    data['deleted_at'] = this.deletedAt;
    if (this.productColors != null) {
      data['product_colors'] =
          this.productColors.map((v) => v.toJson()).toList();
    }
    if (this.ratings != null) {
      data['ratings'] = this.ratings.map((v) => v.toJson()).toList();
    }
    data['choice_id'] = this.choiceID;
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
  ColorIDCart color;

  ProductColorsCart(
      {this.id,
        this.productId,
        this.colorId,
        this.quantity,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.color});

  ProductColorsCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    colorId = json['color_id'];
    quantity = json['quantity'];
    image = json['image'];
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
    deletedAt = json['deleted_at']??"";
    color = json['color'] != null ? new ColorIDCart.fromJson(json['color']) : null;
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
    if (this.color != null) {
      data['color'] = this.color.toJson();
    }
    return data;
  }
}

class ColorIDCart {
  int id;
  String userId;
  String name;
  String colorCode;
  String createdAt="";
  String updatedAt="";
  String deletedAt='';

  ColorIDCart(
      {this.id,
        this.userId,
        this.name,
        this.colorCode,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  ColorIDCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    colorCode = json['color_code'];
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
    deletedAt = json['deleted_at']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['color_code'] = this.colorCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class RatingsCart {
  int id=0;
  String userId='';
  String productId='';
  String rate='';
  String message='';
  String createdAt='';
  String updatedAt='';

  RatingsCart(
      {this.id,
        this.userId,
        this.productId,
        this.rate,
        this.message,
        this.createdAt,
        this.updatedAt});

  RatingsCart.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    userId = json['user_id']??"";
    productId = json['product_id']??"";
    rate = json['rate']??"";
    message = json['message']??'';
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['rate'] = this.rate;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


