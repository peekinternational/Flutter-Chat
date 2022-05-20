import 'dart:convert';

List<FriendRequests> friendRequestsFromJson(String str) => List<FriendRequests>.from(json.decode(str).map((x) => FriendRequests.fromJson(x)));

String friendRequestsToJson(List<FriendRequests> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FriendRequests {
  FriendRequests({
    required this.id,
    required this.status,
    required this.userId,
    required this.friendId,
    required this.projectId,
    required this.updatedByMsg,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.friendReqSenderId,
  });

  String id;
  int status;
  Id userId;
  Id friendId;
  String projectId;
  DateTime updatedByMsg;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String friendReqSenderId;

  factory FriendRequests.fromJson(Map<String, dynamic> json) => FriendRequests(
    id: json["_id"],
    status: json["status"],
    userId: Id.fromJson(json["userId"]),
    friendId: Id.fromJson(json["friendId"]),
    projectId: json["projectId"],
    updatedByMsg: DateTime.parse(json["updatedByMsg"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    friendReqSenderId: json["friendReqSenderId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "status": status,
    "userId": userId.toJson(),
    "friendId": friendId.toJson(),
    "projectId": projectId,
    "updatedByMsg": updatedByMsg.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "friendReqSenderId": friendReqSenderId,
  };
}

class Id {
  Id({
    required this.id,
    required this.userId,
    required this.chatWithRefId,
    required this.name,
    required this.email,
    required this.userImage,
    required this.phone,
    required this.country,
    required this.onlineStatus,
    required this.seenStatus,
    required this.status,
    required this.pStatus,
    required this.lastActiveTime,
    required this.projectId,
    required this.updatedByMsg,
    required this.createdAt,
  });

  String id;
  String userId;
  String chatWithRefId;
  String name;
  String email;
  String userImage;
  String phone;
  String country;
  int onlineStatus;
  int seenStatus;
  int status;
  int pStatus;
  DateTime lastActiveTime;
  String projectId;
  DateTime updatedByMsg;
  DateTime createdAt;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    id: json["_id"],
    userId: json["userId"],
    chatWithRefId: json["chatWithRefId"],
    name: json["name"],
    email: json["email"],
    userImage: json["user_image"],
    phone: json["phone"],
    country: json["country"],
    onlineStatus: json["onlineStatus"],
    seenStatus: json["seenStatus"],
    status: json["status"],
    pStatus: json["pStatus"],
    lastActiveTime: DateTime.parse(json["lastActiveTime"]),
    projectId: json["projectId"],
    updatedByMsg: DateTime.parse(json["updatedByMsg"]),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "chatWithRefId": chatWithRefId,
    "name": name,
    "email": email,
    "user_image": userImage,
    "phone": phone,
    "country": country,
    "onlineStatus": onlineStatus,
    "seenStatus": seenStatus,
    "status": status,
    "pStatus": pStatus,
    "lastActiveTime": lastActiveTime.toIso8601String(),
    "projectId": projectId,
    "updatedByMsg": updatedByMsg.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
  };
}
