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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (usersList != null) {
      data['usersList'] = usersList!.map((v) => v.toJson()).toList();
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
  int? friendReqStatus;
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
  bool selectedForGroup = false;


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
        this.latestMsgCreatedAt,
        this.selectedForGroup
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['chatWithRefId'] = chatWithRefId;
    data['name'] = name;
    data['email'] = email;
    data['user_image'] = userImage;
    data['phone'] = phone;
    data['country'] = country;
    data['onlineStatus'] = onlineStatus;
    data['seenStatus'] = seenStatus;
    data['readReceipts'] = readReceipts;
    data['status'] = status;
    data['pStatus'] = pStatus;
    data['lastActiveTime'] = lastActiveTime;
    data['callStatus'] = callStatus;
    data['voiceCallReceive'] = voiceCallReceive;
    data['videoCallReceive'] = videoCallReceive;
    data['projectId'] = projectId;
    data['updatedByMsg'] = updatedByMsg;
    data['createdAt'] = createdAt;
    data['friendReqId'] = friendReqId;
    data['friendReqStatus'] = friendReqStatus;
    data['friendReqSenderId'] = friendReqSenderId;
    data['usCount'] = usCount;
    // if (this.latestMsg != null) {
    //   data['latestMsg'] = this.latestMsg!.toJson();
    // }
    data['gender'] = gender;
    data['birth'] = birth;
    data['userTitle'] = userTitle;
    data['userProfileUrl'] = userProfileUrl;
    data['isAdmin'] = isAdmin;
    data['emailConfirm'] = emailConfirm;
    data['languageCode'] = languageCode;
    data['isGroup'] = isGroup;
    data['favourite'] = favourite;
    data['token'] = token;
    data['fcm_id'] = fcmId;
    data['rememberMe'] = rememberMe;
    data['secretKey'] = secretKey;
    data['qr_code'] = qrCode;
    data['ring'] = ring;
    data['r_read'] = rRead;
    data['about_url'] = aboutUrl;
    data['terms_url'] = termsUrl;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}


class LatestMsg {
  String sId="";
  String message="";
  int messageType=0;
  String senderId="";
  String createdAt="";



  // int chatType=-1;
  // int status=-1;
  // int isSeen=-1;
  // int isDeleted=-1;
  // int isGroup=-1;
  // int bookmarked=-1;
  // int receiptStatus=-1;
  // String fileSize="";
  // int isSeenCount=-1;
  // int hide=-1;
  // String receiverId="";
  // String projectId="";
  // String senderUserId="";
  // String receiverUserId="";
  // String createdAt="";
  // String updatedAt="";
  // int iV=-1;




  LatestMsg.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    message = json['message'];
    messageType = json['messageType'];
    senderId = json['senderId'];
    createdAt = json['createdAt'];
    // chatType = json['chatType'];
    // status = json['status'];
    // isSeen = json['isSeen'];
    // isDeleted = json['isDeleted'];
    //
    // isGroup = json['isGroup'];
    // bookmarked = json['bookmarked'];
    // receiptStatus = json['receiptStatus'];
    // fileSize = json['fileSize'];
    // isSeenCount = json['isSeenCount'];
    // hide = json['hide'];
    //
    // receiverId = json['receiverId'];
    // projectId = json['projectId'];
    // senderUserId = json['senderUserId'];
    // receiverUserId = json['receiverUserId'];
    // createdAt = json['createdAt'];
    // updatedAt = json['updatedAt'];
    // iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['message'] = message;
    data['messageType'] = messageType;
    data['senderId'] = senderId;
    data['createdAt'] = createdAt;
    // data['chatType'] = this.chatType;
    // data['status'] = this.status;
    // data['isSeen'] = this.isSeen;
    // data['isDeleted'] = this.isDeleted;
    //
    // data['isGroup'] = this.isGroup;
    // data['bookmarked'] = this.bookmarked;
    // data['receiptStatus'] = this.receiptStatus;
    // data['fileSize'] = this.fileSize;
    // data['isSeenCount'] = this.isSeenCount;
    // data['hide'] = this.hide;
    //
    // data['receiverId'] = this.receiverId;
    // data['projectId'] = this.projectId;
    // data['senderUserId'] = this.senderUserId;
    // data['receiverUserId'] = this.receiverUserId;
    // data['createdAt'] = this.createdAt;
    // data['updatedAt'] = this.updatedAt;
    // data['__v'] = this.iV;
    return data;
  }
}

