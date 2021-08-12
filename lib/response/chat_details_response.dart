class GetPrevMessages {
  int ?status;
  List<DataM> ?data;
  String ?message;

  GetPrevMessages({this.status, this.data, this.message});

  GetPrevMessages.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DataM>[];
      json['data'].forEach((v) {
        data!.add(new DataM.fromJson(v));
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

class DataM {
  bool ?seen;
  String ?sId;
  SenderId? senderId;
  String? receiverId;
  String? roomId;
  String? msg;
  String? msgType;
  String? msgCategory;
  String? createdAt;
  String? updatedAt;
  int? iV;

  DataM(
      {this.seen,
        this.sId,
        this.senderId,
        this.receiverId,
        this.roomId,
        this.msg,
        this.msgType,
        this.msgCategory,
        this.createdAt,
        this.updatedAt,
        this.iV});

  DataM.fromJson(Map<String, dynamic> json) {
    seen = json['seen'];
    sId = json['_id'];
    senderId = json['senderId'] != null
        ? new SenderId.fromJson(json['senderId'])
        : null;
    receiverId = json['receiverId'];
    roomId = json['roomId'];
    msg = json['msg'];
    msgType = json['msgType'];
    msgCategory = json['msgCategory'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seen'] = this.seen;
    data['_id'] = this.sId;
    if (this.senderId != null) {
      data['senderId'] = this.senderId!.toJson();
    }
    data['receiverId'] = this.receiverId;
    data['roomId'] = this.roomId;
    data['msg'] = this.msg;
    data['msgType'] = this.msgType;
    data['msgCategory'] = this.msgCategory;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class SenderId {
  String? sId;
  String? username;
  String? profilePicture;

  SenderId({this.sId, this.username, this.profilePicture});

  SenderId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}