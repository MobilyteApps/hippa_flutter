class CreateGroupResponse {
  int? status;
  Data? data;
  String? message;

  CreateGroupResponse({this.status, this.data, this.message});

  CreateGroupResponse.fromJson(Map<String, dynamic> json) {
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
  List<String>? members;
  String? sId;
  String? admin;
  String? title;
  String? groupImage;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.members,
      this.sId,
      this.admin,
      this.title,
      this.groupImage,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    members = json['members'].cast<String>();
    sId = json['_id'];
    admin = json['admin'];
    title = json['title'];
    groupImage = json['groupImage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['members'] = this.members;
    data['_id'] = this.sId;
    data['admin'] = this.admin;
    data['title'] = this.title;
    data['groupImage'] = this.groupImage;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
