import 'dart:convert';

import 'package:floor/floor.dart';

@entity
class UsersModels {
  @PrimaryKey(autoGenerate: true)
  int? myId;
  String sId="";
  String userName="";
  String qrRing="";
  String pImage="";
  String ringName="";
  String ringUserId="";
  String ringValue="";
  int isDefault=-1;
  int ringStatus=-1;
  int onlineStatus=-1;
  int pStatus=-1;
  int callStatus=-1;
  int isGroup=-1;
  int seenStatus=-1;
  int readReceipts=-1;
  String lastActiveTime="";
  String chatWithRefId="";
  String onlineHideStatus="";
  String stopAudioCall="";
  String stopVideoCall="";
  String userId="";
  String updatedByMsg="";
  String friendReqId="";
  int friendReqStatus=-1;
  String friendReqSenderId="";
  int usCount=-1;
  int isSeenCount=-1;
  // @TypeConverters([LatestMsgConverter])
  // LatestMsg? latestMsg;
  String mute="";
  String hide="";
  String block="";
  String hideChat="";
  String unreadUserStatus="";
  int pinStatus=-1;
  int hiddenChat=-1;
  String selectedRingId="";
  String latestMsg="";
  int latestMsgType= 0;
  String latestMsgSenderId="";
  String latestMsgCreatedAt="";


  UsersModels(
     this.myId,
      this.sId,
      this.userName,
      this.qrRing,
      this.pImage,
      this.ringName,
      this.ringUserId,
      this.ringValue,
      this.isDefault,
      this.ringStatus,
      this.onlineStatus,
      this.pStatus,
      this.callStatus,
      this.isGroup,
      this.seenStatus,
      this.readReceipts,
      this.lastActiveTime,
      this.chatWithRefId,
      this.onlineHideStatus,
      this.stopAudioCall,
      this.stopVideoCall,
      this.userId,
      this.updatedByMsg,
      this.friendReqId,
      this.friendReqStatus,
      this.friendReqSenderId,
      this.usCount,
      this.isSeenCount,
      this.mute,
      this.hide,
      this.block,
      this.hideChat,
      this.unreadUserStatus,
      this.pinStatus,
      this.hiddenChat,
      this.selectedRingId,
      this.latestMsg,
      this.latestMsgType,
      this.latestMsgSenderId,
      this.latestMsgCreatedAt
  ); // UsersModels(this.myId);




  UsersModels.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['user_name'];
    qrRing = json['qr_ring'];
    pImage = json['p_image'];
    ringName = json['ring_name'];
    ringUserId = json['ring_user_id'];
    ringValue = json['ring_value'];
    isDefault = json['is_default'];
    ringStatus = json['ring_status'];
    onlineStatus = json['online_status'];
    pStatus = json['pStatus'];
    callStatus = json['callStatus'];
    isGroup = json['isGroup'];
    seenStatus = json['seenStatus'];
    readReceipts = json['readReceipts'];
    lastActiveTime = json['lastActiveTime'];
    chatWithRefId = json['chatWithRefId'];
    onlineHideStatus = json['onlineHideStatus'];
    stopAudioCall = json['stopAudioCall'];
    stopVideoCall = json['stopVideoCall'];
    userId = json['user_id'];
    updatedByMsg = json['updatedByMsg'];
    friendReqId = json['friendReqId'];
    friendReqStatus = json['friendReqStatus'];
    friendReqSenderId = json['friendReqSenderId'];
    usCount = json['usCount'];
    isSeenCount = json['isSeenCount'];
    // latestMsg = json['latestMsg'] != null
    //     ? new LatestMsg.fromJson(json['latestMsg'])
    //     : null;
    mute = json['mute'];
    hide = json['hide'];
    block = json['block'];
    hideChat = json['hideChat'];
    unreadUserStatus = json['unreadUserStatus'];
    pinStatus = json['pinStatus'];
    hiddenChat = json['hiddenChat'];
    selectedRingId = json['selectedRingId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_name'] = this.userName;
    data['qr_ring'] = this.qrRing;
    data['p_image'] = this.pImage;
    data['ring_name'] = this.ringName;
    data['ring_user_id'] = this.ringUserId;
    data['ring_value'] = this.ringValue;
    data['is_default'] = this.isDefault;
    data['ring_status'] = this.ringStatus;
    data['online_status'] = this.onlineStatus;
    data['pStatus'] = this.pStatus;
    data['callStatus'] = this.callStatus;
    data['isGroup'] = this.isGroup;
    data['seenStatus'] = this.seenStatus;
    data['readReceipts'] = this.readReceipts;
    data['lastActiveTime'] = this.lastActiveTime;
    data['chatWithRefId'] = this.chatWithRefId;
    data['onlineHideStatus'] = this.onlineHideStatus;
    data['stopAudioCall'] = this.stopAudioCall;
    data['stopVideoCall'] = this.stopVideoCall;
    data['user_id'] = this.userId;
    data['updatedByMsg'] = this.updatedByMsg;
    data['friendReqId'] = this.friendReqId;
    data['friendReqStatus'] = this.friendReqStatus;
    data['friendReqSenderId'] = this.friendReqSenderId;
    data['usCount'] = this.usCount;
    data['isSeenCount'] = this.isSeenCount;
    // if (this.latestMsg != null) {
    //   data['latestMsg'] = this.latestMsg?.toJson();
    // }
    data['mute'] = this.mute;
    data['hide'] = this.hide;
    data['block'] = this.block;
    data['hideChat'] = this.hideChat;
    data['unreadUserStatus'] = this.unreadUserStatus;
    data['pinStatus'] = this.pinStatus;
    data['hiddenChat'] = this.hiddenChat;
    data['selectedRingId'] = this.selectedRingId;
    return data;
  }
}


class LatestMsgConverter extends TypeConverter<LatestMsg, String> {

  @override
  LatestMsg decode(String databaseValue) {
    final body = json.decode(databaseValue);
    return body;
  }

  @override
  String encode(LatestMsg value) {
    String json = jsonEncode(value.toJson());
    return json;
  }

  LatestMsgConverter();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['message'] = this.message;
    data['messageType'] = this.messageType;
    data['senderId'] = this.senderId;
    data['createdAt'] = this.createdAt;
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