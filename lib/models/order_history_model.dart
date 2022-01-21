class OrderHistoryModel {
  List<OrderHistory> orderHistory;

  OrderHistoryModel({this.orderHistory});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['orderHistory'] != null) {
      orderHistory = <OrderHistory>[];
      json['orderHistory'].forEach((v) {
        orderHistory.add(new OrderHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderHistory != null) {
      data['orderHistory'] = this.orderHistory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderHistory {
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
  String deletedAt;

  OrderHistory(
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
        this.deletedAt});

  OrderHistory.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
