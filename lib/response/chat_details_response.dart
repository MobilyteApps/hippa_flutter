
class GetPrevMessages {
  GetPrevMessages({
     this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory GetPrevMessages.fromJson(Map<String, dynamic> json) => GetPrevMessages(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.roomId,
    this.caseId,
    this.messages,
    this.lawyerId,
    this.clientId,
    this.offer,
    this.hire,
    this.acceptOffer,
    this.purposal,
    this.invitation,
  });

  String? roomId;
  CaseId? caseId;
  List<Message>? messages;
  UserIds? lawyerId;
  UserIds? clientId;
  Offer? offer;
  bool? hire;
  bool ?acceptOffer;
  Purposal? purposal;
  Invitation? invitation;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    roomId: json["roomId"],
    caseId: CaseId.fromJson(json["caseId"]??""),
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    lawyerId: UserIds.fromJson(json["lawyerId"]),
    clientId: UserIds.fromJson(json["clientId"]),
    offer: Offer.fromJson(json["offer"]??""),
    hire: json["hire"],
    acceptOffer: json["acceptOffer"],
    purposal: json.containsKey("purposal") ? Purposal.fromJson(json["purposal"]??null) : null,
    invitation: json.containsKey("invitation") ? Invitation.fromJson(json["invitation"]??null) : null,
    //caseId: CaseId.fromJson(json["caseId"]),
    //purposal: PurposalCaseId.fromJson(json["purposal"]),
  );

  Map<String, dynamic> toJson() => {
    "roomId": roomId,
    "caseId": caseId!.toJson(),
    "messages": List<dynamic>.from(messages!.map((x) => x.toJson())),
    "lawyerId": lawyerId!.toJson(),
    "clientId": clientId!.toJson(),
    "offer": offer!.toJson(),
    "hire": hire,
    "acceptOffer": acceptOffer,
    "purposal": purposal!.toJson(),
    //"invitation": invitation.toJson(),
  };
}

class Invitation {
  Invitation({
    this.isDeleted,
    this.id,
    this.lawyerId,
    this.caseId,
    this.cost,
    this.hourly,
    this.retainer,
    this.detail,
    this.category,
    this.clientId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.acceptInvitation,
  });

  bool? isDeleted;
  String? id;
  String ?lawyerId;
  CaseId ?caseId;
  String ?cost;
  bool? hourly;
  bool ?retainer;
  String? detail;
  String ?category;
  String ?clientId;
  DateTime? createdAt;
  DateTime ?updatedAt;
  int? v;
  bool? acceptInvitation;

  factory Invitation.fromJson(Map<String, dynamic> json) => Invitation(
    isDeleted: json["isDeleted"],
    id: json["_id"],
    lawyerId: json["lawyerId"],
    caseId: json.containsKey("caseId") ? CaseId.fromJson(json["caseId"]) : null,
    cost: json["cost"],
    hourly: json["hourly"],
    retainer: json["retainer"],
    detail: json["detail"],
    category: json["category"],
    clientId: json["clientId"],
    //createdAt: DateTime.parse(json["createdAt"]),
    //updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    acceptInvitation: json["acceptInvitation"],
  );

  Map<String, dynamic> toJson() => {
    "isDeleted": isDeleted,
    "_id": id,
    "lawyerId": lawyerId,
    "caseId": caseId!.toJson(),
    "cost": cost,
    "hourly": hourly,
    "retainer": retainer,
    "detail": detail,
    "category": category,
    "clientId": clientId,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
    "acceptInvitation": acceptInvitation,
  };
}

class CaseId {
  CaseId({
    this.id,
    this.name,
    this.detail,
  });

  String? id;
  String? name;
  String ?detail;

  factory CaseId.fromJson(Map<String, dynamic> json) => CaseId(
    id: json["_id"]??null,
    name: json["name"]??null,
    detail: json["detail"]??null,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "detail": detail,
  };
}

class UserIds {
  UserIds({
    this.role,
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.imageUrl,
    this.phoneNumber,
  });

  String? role;
  String? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? imageUrl;
  String? phoneNumber;

  factory UserIds.fromJson(Map<String, dynamic> json) => UserIds(
    role: json["role"],
    id: json["_id"],
    firstName: json["firstName"],
    middleName: json["middleName"],
    lastName: json["lastName"],
    imageUrl: json["imageUrl"],
    phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "role": role,
    "_id": id,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "imageUrl": imageUrl,
    "phoneNumber": phoneNumber == null ? null : phoneNumber,
  };
}

class Offer {
  Offer({
    this.id,
    this.lawyerId,
    this.clientId,
    this.roomId,
    this.caseId,
    this.cost,
    this.detail,
    this.duration,
    // this.createdAt,
    // this.updatedAt,
    this.v,
    this.acceptOffer,
    this.payment,
  });
  String ?id;
  String ?lawyerId;
  String ?clientId;
  String ?roomId;
  CaseId ?caseId;
  int? cost;
  String ?detail;
  int ?duration;
  // DateTime createdAt;
  // DateTime updatedAt;
  int ?v;
  bool ?acceptOffer;
  bool ?payment;
  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["_id"]??"",
    lawyerId: json["lawyerId"]??"",
    clientId: json["clientId"]??"",
    roomId: json["roomId"]??"",
    caseId: json.containsKey("caseId") ? CaseId.fromJson(json["caseId"]) : CaseId(),
    cost: json["cost"],
    detail: json["detail"],
    duration: json["duration"],
    // createdAt: DateTime.parse(json["createdAt"]),
    // updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    acceptOffer: json["acceptOffer"],
    payment: json.containsKey("payment") ? json["payment"] : false,
  );
  Map<String, dynamic> toJson() => {
    "_id": id,
    "lawyerId": lawyerId,
    "clientId": clientId,
    "roomId": roomId,
    "caseId": caseId,
    "cost": cost,
    "detail": detail,
    "duration": duration,
    // "createdAt": createdAt.toIso8601String(),
    // "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "acceptOffer": acceptOffer,
    "payment": payment,
  };
}

class Message {
  Message({
    this.id,
    this.msg,
    this.msgType,
    this.seen,
    this.createdAt,
    this.senderId,
    this.receiverId,
  });

  String? id;
  String? msg;
  String? msgType;
  bool? seen;
  DateTime? createdAt;
  String? senderId;
  String? receiverId;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["_id"],
    msg: json["msg"],
    msgType: json["msgType"],
    seen: json["seen"],
    createdAt: DateTime.parse(json["createdAt"]),
    senderId: json["senderId"],
    receiverId: json["receiverId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "msg": msg,
    "msgType": msgType,
    "seen": seen,
    "createdAt": createdAt!.toIso8601String(),
    "senderId": senderId,
    "receiverId": receiverId,
  };
}


class Purposal {
  Purposal({
    this.isDeleted,
    this.id,
    this.purposalCaseId,
    this.cost,
    this.detail,
    this.clientId,
    this.lawyerId,
    this.casename,
    this.createdAt,
    this.updatedAt,
  });

  bool? isDeleted;
  String? id;
  String? cost;
  String? detail;
  String? clientId;
  String? lawyerId;
  String? casename;
  DateTime? createdAt;
  DateTime? updatedAt;
  PurposalCaseId? purposalCaseId;

  factory Purposal.fromJson(Map<String, dynamic> json) => Purposal(
    isDeleted: json["isDeleted"]??true,
    id: json["_id"]??null,
    purposalCaseId: json.containsKey("caseId") ? PurposalCaseId.fromJson(json["caseId"]??"") : PurposalCaseId(),
    cost: json["cost"]??"",
    detail: json["detail"]??"",
    clientId: json["clientId"]??"",
    lawyerId: json["lawyerId"]??"",
    createdAt: DateTime.now(), //DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.now(), //DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "isDeleted": isDeleted,
    "_id": id,
    "caseId": purposalCaseId,
    "cost": cost,
    "detail": detail,
    "clientId": clientId,
    "lawyerId": lawyerId,
    "lawyerId": casename,
    "createdAt": "",//createdAt.toIso8601String(),
    "updatedAt": "",//updatedAt.toIso8601String(),
  };
}



class PurposalCaseId {
  PurposalCaseId({
    this.id,
    this.name
  });

  String ?id;
  String ?name;

  factory PurposalCaseId.fromJson(Map<String, dynamic> json) => PurposalCaseId(
    id: json["_id"]??"",
    name: json["name"]??"",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}

