class PlaceOrderDetailModal {
  String productId;
  String quantity;
  String choiceId;

  PlaceOrderDetailModal({this.productId, this.quantity,this.choiceId});

  PlaceOrderDetailModal.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    choiceId = json['choice_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['choice_id'] = this.choiceId;
    return data;
  }
}
