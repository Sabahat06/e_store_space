class UserStore {
  List<Store> store;

  UserStore({this.store});

  UserStore.fromJson(Map<String, dynamic> json) {
    if (json['store'] != null) {
      store = <Store>[];
      json['store'].forEach((v) {
        store.add(new Store.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.store != null) {
      data['store'] = this.store.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Store {
  int id;
  String userId;
  String name;
  String dealType;
  String description;
  String createdAt;
  String updatedAt;
  String picture='';
  String deletedAt='';

  Store(
      {this.id,
        this.userId,
        this.name,
        this.dealType,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.picture
      });

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    dealType = json['deal_type'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at']??"";
    picture = json['picture']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['deal_type'] = this.dealType;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['picture'] = this.picture;
    return data;
  }
}
