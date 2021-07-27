class GetAllUserResponse {
  int? status;
  Data? data;
  String? message;

  GetAllUserResponse({this.status, this.data, this.message});

  GetAllUserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  List<Users>? users;
  int? totalCount;

  Data({this.users, this.totalCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    return data;
  }
}

class Users {
  bool? active;
  bool? deleted;
  String? role;
  bool? passwordModified;
  bool? alllowNotifications;
  String? sId;
  String? name;
  String? email;
  String? password;
  String? gender;
  String? username;
  String? createdAt;
  String? updatedAt;
  String? profilePicture;
  String? token;

  Users(
      {this.active,
      this.deleted,
      this.role,
      this.passwordModified,
      this.alllowNotifications,
      this.sId,
      this.name,
      this.email,
      this.password,
      this.gender,
      this.username,
      this.createdAt,
      this.updatedAt,
      this.profilePicture,
      this.token});

  Users.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    deleted = json['deleted'];
    role = json['role'];
    passwordModified = json['passwordModified'];
    alllowNotifications = json['alllowNotifications'];
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    gender = json['gender'];
    username = json['username'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    profilePicture = json['profilePicture'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['deleted'] = this.deleted;
    data['role'] = this.role;
    data['passwordModified'] = this.passwordModified;
    data['alllowNotifications'] = this.alllowNotifications;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['username'] = this.username;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['profilePicture'] = this.profilePicture;
    data['token'] = this.token;
    return data;
  }
}
