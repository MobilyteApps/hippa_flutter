class SigninResponse {
   int? status;
   Data? data;
   String? message;

  SigninResponse({ this.status, this.data, this.message});

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

  Data( {this.user, this.token
  });

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
  String? sId;
  String? name;
  String ?email;
  String ?gender;
  String ?departmentname;
  String ?address;
  String? phonenumber;
  String? username;
  String? createdAt;
  String? updatedAt;
  String? profilePicture;

  User(
      this.sId,
      this.name,
      this.email,
      this.gender,
      this.departmentname,
      this.address,
      this.phonenumber,
      this.username,
      this.createdAt,
      this.updatedAt,
      this.profilePicture);

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    departmentname = json['departmentname'];
    address = json['address'];
    phonenumber = json['phonenumber'];
    username = json['username'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['departmentname'] = this.departmentname;
    data['address'] = this.address;
    data['phonenumber'] = this.phonenumber;
    data['username'] = this.username;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}
