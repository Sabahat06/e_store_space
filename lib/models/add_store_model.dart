class AddStoreModel {
  AddStore addStore;

  AddStoreModel({this.addStore});

  AddStoreModel.fromJson(Map<String, dynamic> json) {
    addStore = json['addStore'] != null
        ? new AddStore.fromJson(json['addStore'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addStore != null) {
      data['addStore'] = this.addStore.toJson();
    }
    return data;
  }
}

class AddStore {
  String name;
  String dealType;
  String description;
  int userId;
  String updatedAt;
  String createdAt;
  int id;

  AddStore(
      {this.name,
        this.dealType,
        this.description,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id});

  AddStore.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dealType = json['deal_type'];
    description = json['description'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['deal_type'] = this.dealType;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
