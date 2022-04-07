class LatestAndStoreModel {
  List<LatestStore> latestStore;
  List<HomeScreenStore> homeScreenStore;

  LatestAndStoreModel({this.latestStore, this.homeScreenStore});

  LatestAndStoreModel.fromJson(Map<String, dynamic> json) {
    if (json['latestStore'] != null) {
      latestStore = <LatestStore>[];
      json['latestStore'].forEach((v) {
        latestStore.add(new LatestStore.fromJson(v));
      });
    }
    if (json['store'] != null) {
      homeScreenStore = <HomeScreenStore>[];
      json['store'].forEach((v) {
        homeScreenStore.add(new HomeScreenStore.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.latestStore != null) {
      data['latestStore'] = this.latestStore.map((v) => v.toJson()).toList();
    }
    if (this.homeScreenStore != null) {
      data['HomeScreenStore'] =
          this.homeScreenStore.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LatestStore {
  int id;
  String userId;
  String name;
  String dealType;
  String description;
  String picture;
  String createdAt;
  String updatedAt;
  String deletedAt='';

  LatestStore(
      {this.id,
        this.userId,
        this.name,
        this.dealType,
        this.description,
        this.picture,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  LatestStore.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    dealType = json['deal_type'];
    description = json['description'];
    picture = json['picture'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['deal_type'] = this.dealType;
    data['description'] = this.description;
    data['picture'] = this.picture;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class HomeScreenStore {
  int id;
  String userId;
  String name;
  String dealType;
  String description;
  String picture;
  String createdAt;
  String updatedAt;
  String deletedAt='';

  HomeScreenStore(
      {this.id,
        this.userId,
        this.name,
        this.dealType,
        this.description,
        this.picture,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  HomeScreenStore.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    dealType = json['deal_type'];
    description = json['description'];
    picture = json['picture'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['deal_type'] = this.dealType;
    data['description'] = this.description;
    data['picture'] = this.picture;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
