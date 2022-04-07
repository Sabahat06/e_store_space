class HtmlPageModel {
  List<HtmlPages> htmlpages = [];

  HtmlPageModel({this.htmlpages});

  HtmlPageModel.fromJson(Map<String, dynamic> json) {
    if (json['pages'] != null) {
      htmlpages = [];
      json['pages'].forEach((v) {
        htmlpages.add(new HtmlPages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.htmlpages != null) {
      data['pages'] = this.htmlpages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HtmlPages {
  int id;
  String name;
  String content;
  String createdAt;
  String updatedAt;
  String deletedAt='';

  HtmlPages(
      {this.id,
        this.name,
        this.content,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  HtmlPages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
