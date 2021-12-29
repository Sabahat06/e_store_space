import 'package:get/get.dart';
class UsedMobileModel {
  RxList<UsedProducts> products = <UsedProducts>[].obs;
  int totalPages;

  UsedMobileModel({this.products, this.totalPages});

  UsedMobileModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <UsedProducts>[].obs;
      json['products'].forEach((v) {
        products.add(new UsedProducts.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    return data;
  }
}

class UsedProducts {
  String id;
  String customerId;
  String mobileName;
  String mobilePhoto;
  String description;
  String dated;
  String customerName;
  String customerPhone;
  String price;

  UsedProducts(
      {this.id,
        this.customerId,
        this.mobileName,
        this.mobilePhoto,
        this.description,
        this.dated,
        this.price,
        this.customerName,
        this.customerPhone});

  UsedProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    mobileName = json['mobile_name'];
    mobilePhoto = json['mobile_photo'];
    description = json['description'];
    dated = json['dated'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    price=json['mobile_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['mobile_name'] = this.mobileName;
    data['mobile_photo'] = this.mobilePhoto;
    data['description'] = this.description;
    data['dated'] = this.dated;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['mobile_price']=this.price;
    return data;
  }
}