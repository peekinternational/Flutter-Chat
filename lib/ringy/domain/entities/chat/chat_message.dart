
class ChatModel {
      String? sId;
      String? message;
      int? messageType;
      int? chatType;
      int? status;
      int? isSeen;
      int? isDeleted;
      int? isGroup;
      String? groupId;
      int? bookmarked;
      int? receiptStatus;
      String? fileSize;
      int? isSeenCount;
      int? hide;
      SenderId? senderId;
      SenderId? receiverId;
      CommentId? commentIdObj;
      String? projectId;
      String? senderUserId;
      String? receiverUserId;
      String? createdAt;
      String? updatedAt;
      int? iV;
      bool? isInProgress = false;


      ChatModel();


      ChatModel.fromJson(Map<String, dynamic> json) {
            sId = json['_id'];
            message = json['message'];
            messageType = json['messageType'];
            chatType = json['chatType'];
            status = json['status'];
            isSeen = json['isSeen'];
            isDeleted = json['isDeleted'];
            isGroup = json['isGroup'];
            groupId = json['groupId'];
            bookmarked = json['bookmarked'];
            receiptStatus = json['receiptStatus'];
            fileSize = json['fileSize'];
            isSeenCount = json['isSeenCount'];
            hide = json['hide'];
            senderId = json['senderId'] != null
                ? SenderId.fromJson(json['senderId'])
                : null;
            receiverId = json['receiverId'] != null
                ? SenderId.fromJson(json['receiverId'])
                : null;
            commentIdObj = json['commentId'] != null
                ? CommentId.fromJson(json['commentId'])
                : null;
            projectId = json['projectId'];
            senderUserId = json['sender_user_id'];
            receiverUserId = json['receiver_user_id'];
            createdAt = json['createdAt'];
            updatedAt = json['updatedAt'];
            iV = json['__v'];
      }

      Map<String, dynamic> toJson() {
            final Map<String, dynamic> data = <String, dynamic>{};
            data['_id'] = sId;
            data['message'] = message;
            data['messageType'] = messageType;
            data['chatType'] = chatType;
            data['status'] = status;
            data['isSeen'] = isSeen;
            data['isDeleted'] = isDeleted;
            data['isGroup'] = isGroup;
            data['groupId'] = groupId;
            data['bookmarked'] = bookmarked;
            data['receiptStatus'] = receiptStatus;
            data['fileSize'] = fileSize;
            data['isSeenCount'] = isSeenCount;
            data['hide'] = hide;
            if (senderId != null) {
                  data['senderId'] = senderId!.toJson();
            }
            if (receiverId != null) {
                  data['receiverId'] = receiverId!.toJson();
            }
            if (commentIdObj != null) {
                  data['commentId'] = commentIdObj!.toJson();
            }
            data['projectId'] = projectId;
            data['sender_user_id'] = senderUserId;
            data['receiver_user_id'] = receiverUserId;
            data['createdAt'] = createdAt;
            data['updatedAt'] = updatedAt;
            data['__v'] = iV;
            return data;
      }
}

class SenderId {
      String? id;
      String? userName;
      String? pImage;
      String? ringName;
      String? ringUserId;


      SenderId();

  SenderId.fromJson(Map<String, dynamic> json) {
            id = json['_id'];
            userName = json['name'];
            pImage = json['p_image'];
            ringName = json['ring_name'];
            ringUserId = json['ring_user_id'];
      }

      Map<String, dynamic> toJson() {
            final Map<String, dynamic> data = <String, dynamic>{};
            data['_id'] = id;
            data['name'] = userName;
            data['p_image'] = pImage;
            data['ring_name'] = ringName;
            data['ring_user_id'] = ringUserId;
            return data;
      }
}

class CommentId {

      String? id;
      String? message;
      int? messageType;
      int? chatType;
      int? status;
      int? isSeen;
      int? isDeleted;
      int? isGroup;
      int? bookmarked;
      int? receiptStatus;

      SenderId? senderId;
      String? receiverId;
      String? projectId;
      String? senderUserId;
      String? receiverUserId;


      CommentId({
      this.id,
      this.message,
      this.messageType,
      this.chatType,
      this.status,
      this.isSeen,
      this.isDeleted,
      this.isGroup,
      this.bookmarked,
      this.receiptStatus,
      this.senderId,
      this.receiverId,
      this.projectId,
      this.senderUserId,
      this.receiverUserId});

  factory CommentId.fromJson(Map<String, dynamic> json) => CommentId(
            id: json["_id"],
            message: json["message"],
            messageType: json["messageType"],
            chatType: json["chatType"],
            status: json["status"],
            isSeen: json["isSeen"],
            isDeleted: json["isDeleted"],
            isGroup: json["isGroup"],
            bookmarked: json["bookmarked"],
            receiptStatus: json["receiptStatus"],

            senderId: SenderId.fromJson(json["senderId"]),
            receiverId: json["receiverId"],
            projectId: json["projectId"],
            senderUserId: json["senderUserId"],
            receiverUserId: json["receiverUserId"],
      );

      Map<String, dynamic> toJson() => {
            "_id": id,
            "message": message,
            "messageType": messageType,
            "chatType": chatType,
            "status": status,
            "isSeen": isSeen,
            "isDeleted": isDeleted,
            "isGroup": isGroup,
            "bookmarked": bookmarked,
            "receiptStatus": receiptStatus,
            "senderId": senderId?.toJson(),
            "receiverId": receiverId,
            "projectId": projectId,
            "senderUserId": senderUserId,
            "receiverUserId": receiverUserId,
      };
}
class MessageData {
      String? projectId;
      ChatModel? msgData;


      MessageData();

      MessageData.fromJson(Map<String, dynamic> json) {
            projectId = json['projectId'];
            msgData = json['msgData'];
      }

      Map<String, dynamic> toJson() {
            final Map<String, dynamic> data = <String, dynamic>{};
            data['projectId'] = projectId;
            data['msgData'] = msgData;
            return data;
      }
}
















