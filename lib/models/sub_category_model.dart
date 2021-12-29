class SubCategoryModel {
  String id;
  String title;
  String image;

  SubCategoryModel({this.id, this.title});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['sub_cat_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sub_cat_image'] = this.image;
    return data;
  }
}