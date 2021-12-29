class SearchProduct {
  String id;
  String title;

  String salePrice;
  String discount;
  String discountedPrice;

  String subCategoryId;
  String categoryTitle;
  String subCategoryTitle;


  SearchProduct(
      {this.id,
        this.title,

        this.salePrice,
        this.discount,
        this.discountedPrice,

        this.subCategoryId,
        this.categoryTitle,
        this.subCategoryTitle});

  SearchProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];

    salePrice = json['sale_price'];
    discount = json['discount'];
    discountedPrice = json['discounted_price'];

    subCategoryId = json['sub_category_id'];
    categoryTitle = json['category_title'];
    subCategoryTitle = json['sub_category_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;

    data['sale_price'] = this.salePrice;
    data['discount'] = this.discount;
    data['discounted_price'] = this.discountedPrice;


    data['sub_category_id'] = this.subCategoryId;
    data['category_title'] = this.categoryTitle;
    data['sub_category_title'] = this.subCategoryTitle;
    return data;
  }
}
