

import 'package:flutter_chat/ringy/domain/entities/chat_message/socket_models/socket_receive_message.dart';

class ChatModel {
      String? sId;
      String? message;
      int? messageType;
      int? chatType;
      int? status;
      int? isSeen;
      int? isDeleted;

      int? isGroup;
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


      ChatModel(); // ChatModel(
      //     {this.sId,
      //           this.message,
      //           this.messageType,
      //           this.chatType,
      //           this.status,
      //           this.isSeen,
      //           this.isDeleted,
      //
      //           this.isGroup,
      //           this.bookmarked,
      //           this.receiptStatus,
      //           this.fileSize,
      //           this.isSeenCount,
      //           this.hide,
      //           this.senderId,
      //           this.receiverId,
      //           this.projectId,
      //           this.senderUserId,
      //           this.receiverUserId,
      //           this.createdAt,
      //           this.updatedAt,
      //           this.iV});

      ChatModel.fromJson(Map<String, dynamic> json) {
            sId = json['_id'];
            message = json['message'];
            messageType = json['messageType'];
            chatType = json['chatType'];
            status = json['status'];
            isSeen = json['isSeen'];
            isDeleted = json['isDeleted'];

            isGroup = json['isGroup'];
            bookmarked = json['bookmarked'];
            receiptStatus = json['receiptStatus'];
            fileSize = json['fileSize'];
            isSeenCount = json['isSeenCount'];
            hide = json['hide'];
            senderId = json['senderId'] != null
                ? new SenderId.fromJson(json['senderId'])
                : null;
            receiverId = json['receiverId'] != null
                ? new SenderId.fromJson(json['receiverId'])
                : null;
            commentIdObj = json['commentId'] != null
                ? new CommentId.fromJson(json['commentId'])
                : null;
            projectId = json['projectId'];
            senderUserId = json['sender_user_id'];
            receiverUserId = json['receiver_user_id'];
            createdAt = json['createdAt'];
            updatedAt = json['updatedAt'];
            iV = json['__v'];
      }

      Map<String, dynamic> toJson() {
            final Map<String, dynamic> data = new Map<String, dynamic>();
            data['_id'] = this.sId;
            data['message'] = this.message;
            data['messageType'] = this.messageType;
            data['chatType'] = this.chatType;
            data['status'] = this.status;
            data['isSeen'] = this.isSeen;
            data['isDeleted'] = this.isDeleted;

            data['isGroup'] = this.isGroup;
            data['bookmarked'] = this.bookmarked;
            data['receiptStatus'] = this.receiptStatus;
            data['fileSize'] = this.fileSize;
            data['isSeenCount'] = this.isSeenCount;
            data['hide'] = this.hide;
            if (this.senderId != null) {
                  data['senderId'] = this.senderId!.toJson();
            }
            if (this.receiverId != null) {
                  data['receiverId'] = this.receiverId!.toJson();
            }
            if (this.commentIdObj != null) {
                  data['commentId'] = this.commentIdObj!.toJson();
            }
            data['projectId'] = this.projectId;
            data['sender_user_id'] = this.senderUserId;
            data['receiver_user_id'] = this.receiverUserId;
            data['createdAt'] = this.createdAt;
            data['updatedAt'] = this.updatedAt;
            data['__v'] = this.iV;
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
            userName = json['user_name'];
            pImage = json['p_image'];
            ringName = json['ring_name'];
            ringUserId = json['ring_user_id'];
      }

      Map<String, dynamic> toJson() {
            final Map<String, dynamic> data = new Map<String, dynamic>();
            data['_id'] = this.id;
            data['user_name'] = this.userName;
            data['p_image'] = this.pImage;
            data['ring_name'] = this.ringName;
            data['ring_user_id'] = this.ringUserId;
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
            final Map<String, dynamic> data = new Map<String, dynamic>();
            data['projectId'] = this.projectId;
            data['msgData'] = this.msgData;
            return data;
      }
}
















