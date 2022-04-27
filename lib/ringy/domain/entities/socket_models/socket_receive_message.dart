class SocketReceiveMessage {
  String? selectFrienddata;
  MsgData? msgData;
  String? userId;

  SocketReceiveMessage({this.selectFrienddata, this.msgData, this.userId});

  SocketReceiveMessage.fromJson(Map<dynamic, dynamic> json) {
    selectFrienddata = json['selectFrienddata'];
    msgData =
    json['msgData'] != null ? MsgData.fromJson(json['msgData']) : null;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['selectFrienddata'] = selectFrienddata;
    if (msgData != null) {
      data['msgData'] = msgData!.toJson();
    }
    data['userId'] = userId;
    return data;
  }
}

class MsgData {
  String? receiverImage;
  String? id;
  String? message;
  String? senderImage;
  String? createdAt;
  SenderIds? senderId;
  String? senderName;
  SenderIds? receiverId;
  int? messageType;
  int? bookmarked;
  int? isGroup;
  int? receiptStatus;
  int? chatType;
  List? bookmarkedChat;

  MsgData(
      {this.receiverImage,
        this.message,
        this.id,
        this.senderImage,
        this.createdAt,
        this.senderId,
        this.senderName,
        this.receiverId,
        this.messageType,
        this.bookmarked,
        this.isGroup,
        this.receiptStatus,
        this.chatType,
        this.bookmarkedChat
      });

  MsgData.fromJson(Map<String, dynamic> json) {
    receiverImage = json['receiverImage'];
    id = json['id'];
    message = json['message'];
    senderImage = json['senderImage'];
    createdAt = json['createdAt'];
    senderId = json['senderId'] != null
        ? SenderIds.fromJson(json['senderId'])
        : null;
    senderName = json['senderName'];
    receiverId = json['receiverId'] != null
        ? SenderIds.fromJson(json['receiverId'])
        : null;
    messageType = json['messageType'];
    bookmarked = json['bookmarked'];
    isGroup = json['isGroup'];
    receiptStatus = json['receiptStatus'];
    chatType = json['chatType'];
    bookmarkedChat = json['bookmarkedChat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receiverImage'] = receiverImage;
    data['id'] = id;
    data['message'] = message;
    data['senderImage'] = senderImage;
    data['createdAt'] = createdAt;
    if (senderId != null) {
      data['senderId'] = senderId!.toJson();
    }
    data['senderName'] = senderName;
    if (receiverId != null) {
      data['receiverId'] = receiverId!.toJson();
    }
    data['messageType'] = messageType;
    data['bookmarked'] = bookmarked;
    data['isGroup'] = isGroup;
    data['receiptStatus'] = receiptStatus;
    data['chatType'] = chatType;
    data['bookmarkedChat'] = bookmarkedChat;
    return data;
  }
}

class SenderIds {
  String? sId;

  SenderIds({this.sId});

  SenderIds.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    return data;
  }
}
