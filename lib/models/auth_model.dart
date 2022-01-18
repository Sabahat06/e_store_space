import 'package:cached_map/cached_map.dart';

class AuthResponse {
  String token;
  User user;

  AuthResponse({this.token, this.user});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  String emailVerifiedAt='';
  String phoneNo;
  String address;
  String city;
  String picture='';
  String createdAt;
  String updatedAt;
  String deletedAt='';

  User(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.phoneNo,
        this.address,
        this.city,
        this.picture,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at']??'';
    phoneNo = json['phone_no'];
    address = json['address'];
    city = json['city'];
    picture = json['picture']??"";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone_no'] = this.phoneNo;
    data['address'] = this.address;
    data['city'] = this.city;
    data['picture'] = this.picture;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }

  /// member functions

  static Future<String> saveUserToCache(AuthResponse user) async{
    Mapped cacheJson = await Mapped.getInstance();
    try{
      cacheJson.saveFile(file: user.toJson(), cachedFileName: "AuthResponse");
    }
    catch(e){
      return "Failed to save user due to: $e";
    }
    return "Save user to cache successfully ";
  }



  static Future<String> deleteCachedUser()async{
    Mapped cacheJson = await Mapped.getInstance();
    try{
      cacheJson.deleteFile(cachedFileName: "AuthResponse");
    }
    catch(e){
      return "Some Problem accoured while deleting user File:$e";
    }
    return "Deleted user to cache successfully";

  }
}
