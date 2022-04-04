class UsersModel {
  List<UsersList>? usersList;

  UsersModel({this.usersList});

  UsersModel.fromJson(Map<String, dynamic> json) {
    if (json['usersList'] != null) {
      usersList = <UsersList>[];
      json['usersList'].forEach((v) {
        usersList!.add(UsersList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.usersList != null) {
      data['usersList'] = this.usersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UsersList {
  String? sId;
  String? userId;
  String? chatWithRefId;
  String? name;
  String? email;
  String? userImage;
  String? phone;
  String? country;
  int? onlineStatus;
  int? seenStatus;
  int? readReceipts;
  int? status;
  int? pStatus;
  String? lastActiveTime;
  int? callStatus;
  int? voiceCallReceive;
  int? videoCallReceive;
  String? projectId;
  String? updatedByMsg;
  String? createdAt;
  String? friendReqId;
  String? friendReqStatus;
  String? friendReqSenderId;
  int? usCount;
  // LatestMsg? latestMsg;
  String? gender;
  String? birth;
  String? userTitle;
  String? userProfileUrl;
  int? isAdmin;
  int? emailConfirm;
  String? languageCode;
  int? isGroup;
  int? favourite;
  String? token;
  String? fcmId;
  int? rememberMe;
  String? secretKey;
  String? qrCode;
  String? ring;
  int? rRead;
  String? aboutUrl;
  String? termsUrl;
  String? updatedAt;
  int? iV;
  String latestMsg="";
  int latestMsgType= 0;
  String latestMsgSenderId="";
  String latestMsgCreatedAt="";


  UsersList(this.sId,
        this.userId,
        this.chatWithRefId,
        this.name,
        this.email,
        this.userImage,
        this.phone,
        this.country,
        this.onlineStatus,
        this.seenStatus,
        this.readReceipts,
        this.status,
        this.pStatus,
        this.lastActiveTime,
        this.callStatus,
        this.voiceCallReceive,
        this.videoCallReceive,
        this.projectId,
        this.updatedByMsg,
        this.createdAt,
        this.friendReqId,
        this.friendReqStatus,
        this.friendReqSenderId,
        this.usCount,
        // this.latestMsg,
        this.gender,
        this.birth,
        this.userTitle,
        this.userProfileUrl,
        this.isAdmin,
        this.emailConfirm,
        this.languageCode,
        this.isGroup,
        this.favourite,
        this.token,
        this.fcmId,
        this.rememberMe,
        this.secretKey,
        this.qrCode,
        this.ring,
        this.rRead,
        this.aboutUrl,
        this.termsUrl,
        this.updatedAt,
        this.iV,
        this.latestMsg,
        this.latestMsgType,
        this.latestMsgSenderId,
        this.latestMsgCreatedAt
      );

  UsersList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    chatWithRefId = json['chatWithRefId'];
    name = json['name'];
    email = json['email'];
    userImage = json['user_image'];
    phone = json['phone'];
    country = json['country'];
    onlineStatus = json['onlineStatus'];
    seenStatus = json['seenStatus'];
    readReceipts = json['readReceipts'];
    status = json['status'];
    pStatus = json['pStatus'];
    lastActiveTime = json['lastActiveTime'];
    callStatus = json['callStatus'];
    voiceCallReceive = json['voiceCallReceive'];
    videoCallReceive = json['videoCallReceive'];
    projectId = json['projectId'];
    updatedByMsg = json['updatedByMsg'];
    createdAt = json['createdAt'];
    friendReqId = json['friendReqId'];
    friendReqStatus = json['friendReqStatus'];
    friendReqSenderId = json['friendReqSenderId'];
    usCount = json['usCount'];
    // latestMsg = json['latestMsg'] != null
    //     ? LatestMsg.fromJson(json['latestMsg'])
    //     : null;
    gender = json['gender'];
    birth = json['birth'];
    userTitle = json['userTitle'];
    userProfileUrl = json['userProfileUrl'];
    isAdmin = json['isAdmin'];
    emailConfirm = json['emailConfirm'];
    languageCode = json['languageCode'];
    isGroup = json['isGroup'];
    favourite = json['favourite'];
    token = json['token'];
    fcmId = json['fcm_id'];
    rememberMe = json['rememberMe'];
    secretKey = json['secretKey'];
    qrCode = json['qr_code'];
    ring = json['ring'];
    rRead = json['r_read'];
    aboutUrl = json['about_url'];
    termsUrl = json['terms_url'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['chatWithRefId'] = this.chatWithRefId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['user_image'] = this.userImage;
    data['phone'] = this.phone;
    data['country'] = this.country;
    data['onlineStatus'] = this.onlineStatus;
    data['seenStatus'] = this.seenStatus;
    data['readReceipts'] = this.readReceipts;
    data['status'] = this.status;
    data['pStatus'] = this.pStatus;
    data['lastActiveTime'] = this.lastActiveTime;
    data['callStatus'] = this.callStatus;
    data['voiceCallReceive'] = this.voiceCallReceive;
    data['videoCallReceive'] = this.videoCallReceive;
    data['projectId'] = this.projectId;
    data['updatedByMsg'] = this.updatedByMsg;
    data['createdAt'] = this.createdAt;
    data['friendReqId'] = this.friendReqId;
    data['friendReqStatus'] = this.friendReqStatus;
    data['friendReqSenderId'] = this.friendReqSenderId;
    data['usCount'] = this.usCount;
    // if (this.latestMsg != null) {
    //   data['latestMsg'] = this.latestMsg!.toJson();
    // }
    data['gender'] = this.gender;
    data['birth'] = this.birth;
    data['userTitle'] = this.userTitle;
    data['userProfileUrl'] = this.userProfileUrl;
    data['isAdmin'] = this.isAdmin;
    data['emailConfirm'] = this.emailConfirm;
    data['languageCode'] = this.languageCode;
    data['isGroup'] = this.isGroup;
    data['favourite'] = this.favourite;
    data['token'] = this.token;
    data['fcm_id'] = this.fcmId;
    data['rememberMe'] = this.rememberMe;
    data['secretKey'] = this.secretKey;
    data['qr_code'] = this.qrCode;
    data['ring'] = this.ring;
    data['r_read'] = this.rRead;
    data['about_url'] = this.aboutUrl;
    data['terms_url'] = this.termsUrl;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

