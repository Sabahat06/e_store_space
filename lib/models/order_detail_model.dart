class OrderDetailModel {
  List<OrderDetails> orderDetails;

  OrderDetailModel({this.orderDetails});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['orderDetails'] != null) {
      orderDetails = <OrderDetails>[];
      json['orderDetails'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  int id;
  String userId;
  String price;
  String discount;
  String status;
  String deliveryCharge;
  String deliveryTimeSlot;
  String deliveryDate;
  String shapingAddress;
  String createdAt;
  String updatedAt;
  String deletedAt='';
  List<OrderProducts> orderProducts;

  OrderDetails(
      {this.id,
        this.userId,
        this.price,
        this.discount,
        this.status,
        this.deliveryCharge,
        this.deliveryTimeSlot,
        this.deliveryDate,
        this.shapingAddress,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.orderProducts});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    price = json['price'];
    discount = json['discount'];
    status = json['status'];
    deliveryCharge = json['delivery_charge'];
    deliveryTimeSlot = json['delivery_time_slot'];
    deliveryDate = json['delivery_date'];
    shapingAddress = json['shaping_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at']??"";
    if (json['products'] != null) {
      orderProducts = <OrderProducts>[];
      json['products'].forEach((v) {
        orderProducts.add(new OrderProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['status'] = this.status;
    data['delivery_charge'] = this.deliveryCharge;
    data['delivery_time_slot'] = this.deliveryTimeSlot;
    data['delivery_date'] = this.deliveryDate;
    data['shaping_address'] = this.shapingAddress;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.orderProducts != null) {
      data['products'] = this.orderProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderProducts {
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
  Pivot pivot;

  OrderProducts(
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
        this.pivot});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    picture = json['picture'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at']??'';
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  String productId;
  String orderId;
  String colorId;
  String price;
  String discount;
  String quantity;

  Pivot(
      {this.productId,
        this.orderId,
        this.colorId,
        this.price,
        this.discount,
        this.quantity});

  Pivot.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    orderId = json['order_id'];
    colorId = json['color_id'];
    price = json['price'];
    discount = json['discount'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['order_id'] = this.orderId;
    data['color_id'] = this.colorId;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['quantity'] = this.quantity;
    return data;
  }
}
