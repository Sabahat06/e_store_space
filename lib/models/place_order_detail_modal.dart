class PlaceOrderDetailModal {
  String product_id;
  String color_id;
  String price;
  String discount;
  String quantity;

  PlaceOrderDetailModal({this.product_id, this.quantity,this.price, this.discount, this.color_id});

  PlaceOrderDetailModal.fromJson(Map<String, dynamic> json) {
    product_id = json['product_id'];
    color_id = json['color_id'];
    price = json['price'];
    discount = json['discount'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.product_id;
    data['color_id'] = this.color_id;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['quantity'] = this.quantity;
    return data;
  }
}

class SelectedProductSeller {
  String product_id;

  SelectedProductSeller({this.product_id,});

  SelectedProductSeller.fromJson(Map<String, dynamic> json) {
    product_id = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.product_id;
    return data;
  }
}
