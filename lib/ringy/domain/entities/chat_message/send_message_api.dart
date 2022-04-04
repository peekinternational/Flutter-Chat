class SendMessageDataModel {
  String? projectId;
  String? selectedUserData;
  SendMessageData? msgData;


  SendMessageDataModel();

  SendMessageDataModel.fromJson(Map<String, dynamic> json) {
    projectId = json['projectId'];
    selectedUserData = json['selectedUserData'];
    msgData = json['msgData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['projectId'] = projectId;
    data['selectedUserData'] = selectedUserData;
    data['msgData'] = msgData;
    return data;
  }
}

class SendMessageData {
  int? chatType;
  String? senderId;
  String? senderName;
  String? receiverId;
  String? message;
  String? senderImage;
  String? receiverImage;
  int? messageType;
  int? isSeen;
  int? receiptStatus;


  SendMessageData();

  SendMessageData.fromJson(Map<String, dynamic> json) {
    chatType = json['chatType'];
    senderId = json['senderId'];
    senderName = json['senderName'];
    receiverId = json['receiverId'];
    message = json['message'];
    senderImage = json['senderImage'];
    receiverImage = json['receiverImage'];
    messageType = json['messageType'];
    isSeen = json['isSeen'];
    receiptStatus = json['receiptStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatType'] = chatType;
    data['senderId'] = senderId;
    data['senderName'] = senderName;
    data['receiverId'] = receiverId;
    data['message'] = message;
    data['senderImage'] = senderImage;
    data['receiverImage'] = receiverImage;
    data['messageType'] = messageType;
    data['isSeen'] = isSeen;
    data['receiptStatus'] = receiptStatus;

    return data;
  }
}