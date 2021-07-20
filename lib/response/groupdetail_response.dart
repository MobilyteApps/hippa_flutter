class GroupDetailResponse {
  int? status;
  List<Data>? data;
  String ?message;

  GroupDetailResponse({this.status, this.data, this.message});

  GroupDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? sId;
  List<Members> ?members;
  String? admin;
  String ?title;
  String ?groupImage;
  String ?createdAt;
  String ?updatedAt;

  Data(
      {this.sId,
        this.members,
        this.admin,
        this.title,
        this.groupImage,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
    admin = json['admin'];
    title = json['title'];
    groupImage = json['groupImage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    data['admin'] = this.admin;
    data['title'] = this.title;
    data['groupImage'] = this.groupImage;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Members {
  String ?sId;
  bool? active;
  bool ?deleted;
  String? role;
  String ?name;
  String ?email;
  String ?password;
  String ?gender;
  String ?username;
  String ?createdAt;
  String ?updatedAt;
  String ?profilePicture;
  String ?token;
  int ?phonenumber;
  int ?oTPvalue;
  bool? passwordModified;

  Members(
      {this.sId,
        this.active,
        this.deleted,
        this.role,
        this.name,
        this.email,
        this.password,
        this.gender,
        this.username,
        this.createdAt,
        this.updatedAt,
        this.profilePicture,
        this.token,
        this.phonenumber,
        this.oTPvalue,
        this.passwordModified});

  Members.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    active = json['active'];
    deleted = json['deleted'];
    role = json['role'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    gender = json['gender'];
    username = json['username'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    profilePicture = json['profilePicture'];
    token = json['token'];
    phonenumber = json['phonenumber'];
    oTPvalue = json['OTPvalue'];
    passwordModified = json['passwordModified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['active'] = this.active;
    data['deleted'] = this.deleted;
    data['role'] = this.role;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['username'] = this.username;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['profilePicture'] = this.profilePicture;
    data['token'] = this.token;
    data['phonenumber'] = this.phonenumber;
    data['OTPvalue'] = this.oTPvalue;
    data['passwordModified'] = this.passwordModified;
    return data;
  }
}