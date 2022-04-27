class GroupList {
  String? sId;
  List<Members>? members;
  int? status;
  int? isGroup;
  String? name;
  String? image;
  String? creatorUserId;
  String? projectId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? updatedByMsg;
  int? groupCallStatus;
  String latestMsg="";
  int latestMsgType= 0;
  String latestMsgSenderId="";
  String latestMsgCreatedAt="";

  GroupList(
      this.sId,
        this.members,
        this.status,
        this.isGroup,
        this.name,
        this.image,
        this.creatorUserId,
        this.projectId,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.updatedByMsg,
        this.groupCallStatus,
        this.latestMsg,
        this.latestMsgType,
        this.latestMsgSenderId,
        this.latestMsgCreatedAt,
      );

  GroupList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
    status = json['status'];
    isGroup = json['isGroup'];
    name = json['name'];
    image = json['group_image'];
    creatorUserId = json['creatorUserId'];
    projectId = json['projectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    updatedByMsg = json['updatedByMsg'];
    groupCallStatus = json['groupCallStatus'];
    // latestMsg = json['latestMsg'];
    // latestMsgType = json['latestMsgType'];
    // latestMsg = json['latestMsg'];
    // latestMsg = json['latestMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['isGroup'] = isGroup;
    data['name'] = name;
    data['group_image'] = image;
    data['creatorUserId'] = creatorUserId;
    data['projectId'] = projectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['updatedByMsg'] = updatedByMsg;
    return data;
  }
}

class Members {
  String? sId;
  String? name;
  String? email;
  String? userImage;
  String? userId;

  Members({this.sId, this.name, this.email, this.userImage, this.userId});

  Members.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    userImage = json['user_image'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['user_image'] = userImage;
    data['userId'] = userId;
    return data;
  }
}
