import 'package:get/get.dart';

class ProductDetailsModel {
  ProductDetails productDetails;
  String rating;

  ProductDetailsModel({this.productDetails, this.rating});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    productDetails = json['product_details'] != null
        ? new ProductDetails.fromJson(json['product_details'])
        : null;
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productDetails != null) {
      data['product_details'] = this.productDetails.toJson();
    }
    data['rating'] = this.rating;
    return data;
  }
}

class ProductDetails {
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
  List<ProductColors> productColors;
  List<Ratings> ratings;

  ProductDetails(
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
      });

  ProductDetails.fromJson(Map<String, dynamic> json) {
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
    if (json['product_colors'] != null) {
      productColors = <ProductColors>[];
      json['product_colors'].forEach((v) {
        productColors.add(new ProductColors.fromJson(v));
      });
    }
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings.add(new Ratings.fromJson(v));
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
    if (this.productColors != null) {
      data['product_colors'] =
          this.productColors.map((v) => v.toJson()).toList();
    }
    if (this.ratings != null) {
      data['ratings'] = this.ratings.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductColors {
  int id;
  String productId;
  String colorId;
  String quantity;
  String image;
  String createdAt="";
  String updatedAt="";
  String deletedAt='';
  ColorID color;

  ProductColors(
      {this.id,
        this.productId,
        this.colorId,
        this.quantity,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.color});

  ProductColors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    colorId = json['color_id'];
    quantity = json['quantity'];
    image = json['image'];
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
    deletedAt = json['deleted_at']??"";
    color = json['color'] != null ? new ColorID.fromJson(json['color']) : null;
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

class ColorID {
  int id;
  String userId;
  String name;
  String colorCode;
  String createdAt="";
  String updatedAt="";
  String deletedAt='';

  ColorID(
      {this.id,
        this.userId,
        this.name,
        this.colorCode,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  ColorID.fromJson(Map<String, dynamic> json) {
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

class Ratings {
  int id=0;
  String userId='';
  String productId='';
  String rate='';
  String message='';
  String createdAt='';
  String updatedAt='';

  Ratings(
      {this.id,
        this.userId,
        this.productId,
        this.rate,
        this.message,
        this.createdAt,
        this.updatedAt});

  Ratings.fromJson(Map<String, dynamic> json) {
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
