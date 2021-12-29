import 'package:e_store_space/models/order_history_model.dart';

class DashBoard {
  Orders latestOrder;
  String deliveredOrders;
  String pendingOrders;
  String totalSpending;
  String walletBalance;

  DashBoard(
      {this.latestOrder,
        this.deliveredOrders,
        this.pendingOrders,
        this.totalSpending,
        this.walletBalance});

  DashBoard.fromJson(Map<String, dynamic> json) {
    latestOrder = json['latest_order'] != null
        ? new Orders.fromJson(json['latest_order'])
        : null;
    deliveredOrders = json['delivered_orders'];
    pendingOrders = json['pending_orders'];
    totalSpending = json['total_spending'];
    walletBalance = json['wallet_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.latestOrder != null) {
      data['latest_order'] = this.latestOrder.toJson();
    }
    data['delivered_orders'] = this.deliveredOrders;
    data['pending_orders'] = this.pendingOrders;
    data['total_spending'] = this.totalSpending;
    data['wallet_balance'] = this.walletBalance;
    return data;
  }
}

class LatestOrder {
  String id;
  String customerId;
  String deliveryDate;
  String slotId;
  String timeslotFrom;
  String timeslotTo;
  String orderNotes;
  String amount;
  String productDelivery;
  String isPaid;
  String paidAmount;
  String paidDate;
  String billingAddress;
  String status;
  String createdDate;
  String verifiedDate;
  String updatedDate;
  String cancelledDate;
  String deletedFlag;
  String userId;
  String label;
  String timeFrom;
  String searchDate='';
  String timeTo;
  List<OrderDetails> orderDetails;

  LatestOrder(
      {this.id,
        this.customerId,
        this.deliveryDate,
        this.slotId,
        this.timeslotFrom,
        this.timeslotTo,
        this.orderNotes,
        this.amount,
        this.productDelivery,
        this.isPaid,
        this.paidAmount,
        this.paidDate,
        this.billingAddress,
        this.status,
        this.createdDate,
        this.verifiedDate,
        this.updatedDate,
        this.cancelledDate,
        this.deletedFlag,
        this.userId,
        this.label,
        this.timeFrom,
        this.timeTo,
        this.orderDetails,
        this.searchDate,});

  LatestOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    deliveryDate = json['delivery_date'];
    slotId = json['slot_id'];
    timeslotFrom = json['timeslot_from'];
    timeslotTo = json['timeslot_to'];
    orderNotes = json['order_notes'];
    amount = json['amount'];
    productDelivery = json['product_delivery'];
    isPaid = json['is_paid'];
    paidAmount = json['paid_amount'];
    paidDate = json['paid_date'];
    billingAddress = json['billing_address'];
    status = json['status'];
    createdDate = json['created_date'];
    verifiedDate = json['verified_date'];
    updatedDate = json['updated_date'];
    cancelledDate = json['cancelled_date'];
    deletedFlag = json['deleted_flag'];
    userId = json['user_id'];
    label = json['label'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    searchDate = json['search_date']??"";
    if (json['order_details'] != null) {
      orderDetails = new List<OrderDetails>();
      json['order_details'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['delivery_date'] = this.deliveryDate;
    data['slot_id'] = this.slotId;
    data['timeslot_from'] = this.timeslotFrom;
    data['timeslot_to'] = this.timeslotTo;
    data['order_notes'] = this.orderNotes;
    data['amount'] = this.amount;
    data['product_delivery'] = this.productDelivery;
    data['is_paid'] = this.isPaid;
    data['paid_amount'] = this.paidAmount;
    data['paid_date'] = this.paidDate;
    data['billing_address'] = this.billingAddress;
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    data['verified_date'] = this.verifiedDate;
    data['updated_date'] = this.updatedDate;
    data['cancelled_date'] = this.cancelledDate;
    data['deleted_flag'] = this.deletedFlag;
    data['user_id'] = this.userId;
    data['label'] = this.label;
    data['time_from'] = this.timeFrom;
    data['time_to'] = this.timeTo;
    data['search_date'] = this.searchDate;
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  String id;
  String orderId;
  String productId;
  String saleAmount;
  String saleDiscount;
  String saleQuantity;
  String unitId;
  String categoryId;
  String subCategoryId;
  String productPhoto;
  String unitValue;
  String productTitle;
  String urduTitle;
  String categoryTitle;
  String subCategoryTitle;
  String unitName;
  String discountedPrice;
  String subTotal;

  OrderDetails(
      {this.id,
        this.orderId,
        this.productId,
        this.saleAmount,
        this.saleDiscount,
        this.saleQuantity,
        this.unitId,
        this.categoryId,
        this.subCategoryId,
        this.productPhoto,
        this.unitValue,
        this.productTitle,
        this.urduTitle,
        this.categoryTitle,
        this.subCategoryTitle,
        this.unitName,
        this.discountedPrice,
        this.subTotal});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    saleAmount = json['sale_amount'];
    saleDiscount = json['sale_discount'];
    saleQuantity = json['sale_quantity'];
    unitId = json['unit_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    productPhoto = json['product_photo'];
    unitValue = json['unit_value'];
    productTitle = json['product_title'];
    urduTitle = json['urdu_title'];
    categoryTitle = json['category_title'];
    subCategoryTitle = json['sub_category_title'];
    unitName = json['unit_name'];
    discountedPrice = json['discounted_price'];
    subTotal = json['sub_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['sale_amount'] = this.saleAmount;
    data['sale_discount'] = this.saleDiscount;
    data['sale_quantity'] = this.saleQuantity;
    data['unit_id'] = this.unitId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['product_photo'] = this.productPhoto;
    data['unit_value'] = this.unitValue;
    data['product_title'] = this.productTitle;
    data['urdu_title'] = this.urduTitle;
    data['category_title'] = this.categoryTitle;
    data['sub_category_title'] = this.subCategoryTitle;
    data['unit_name'] = this.unitName;
    data['discounted_price'] = this.discountedPrice;
    data['sub_total'] = this.subTotal;
    return data;
  }
}
