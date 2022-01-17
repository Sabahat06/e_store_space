class ProductCategory {
  List<ProductCategoryModel> productCategoryModel = [];

  ProductCategory({this.productCategoryModel});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    if (json['product_category'] != null) {
      productCategoryModel = <ProductCategoryModel>[];
      json['product_category'].forEach((v) {
        productCategoryModel.add(new ProductCategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productCategoryModel != null) {
      data['product_category'] =
          this.productCategoryModel.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductCategoryModel {
  int id;
  String userId;
  String name;
  String description;
  String picture;
  String createdAt;
  String updatedAt;
  String deletedAt='';

  ProductCategoryModel(
      {this.id,
        this.userId,
        this.name,
        this.description,
        this.picture,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    description = json['description'];
    picture = json['picture'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at']='';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['picture'] = this.picture;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
