class SigninResponse {
  int? status;
  Data? data;
  String? message;

  SigninResponse({this.status, this.data, this.message});

  SigninResponse.fromJson(Map<String, dynamic> json) {
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
  User? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  bool? active;
  bool? deleted;
  String? role;
  bool? passwordModified;
  String? sId;
  String? name;
  String? email;
  String? address;
  String? gender;
  int? phonenumber;
  String? createdAt;
  String? updatedAt;

  User(
      {this.active,
      this.deleted,
      this.role,
      this.passwordModified,
      this.sId,
      this.name,
      this.email,
      this.address,
      this.gender,
      this.phonenumber,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    deleted = json['deleted'];
    role = json['role'];
    passwordModified = json['passwordModified'];
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    gender = json['gender'];
    phonenumber = json['phonenumber'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['deleted'] = this.deleted;
    data['role'] = this.role;
    data['passwordModified'] = this.passwordModified;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['phonenumber'] = this.phonenumber;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
