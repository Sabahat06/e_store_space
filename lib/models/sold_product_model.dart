class SoldProductModel {
  List<SoldProduct> soldProduct;

  SoldProductModel({this.soldProduct});

  SoldProductModel.fromJson(Map<String, dynamic> json) {
    if (json['product_id'] != null) {
      soldProduct = <SoldProduct>[];
      json['product_id'].forEach((v) {
        soldProduct.add(new SoldProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.soldProduct != null) {
      data['product_id'] = this.soldProduct.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SoldProduct {
  int id;
  String userId;
  String categoryId;
  String name;
  String description;
  String price;
  String picture;
  String createdAt;
  String updatedAt;
  String deletedAt='';
  String ratingsAverage;

  SoldProduct(
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
        this.ratingsAverage});

  SoldProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    picture = json['picture'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at']??"";
    ratingsAverage = json['ratings_average'];
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
    data['ratings_average'] = this.ratingsAverage;
    return data;
  }
}
