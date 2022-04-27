import 'dart:convert';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/ringy/domain/entities/chat/chal_file_share.dart';
import 'package:flutter_chat/ringy/domain/entities/chat/chat_message.dart';
import 'package:flutter_chat/ringy/domain/entities/chat/send_message_api.dart';
import 'package:flutter_chat/ringy/domain/entities/chat/update_chat_api.dart';
import 'package:flutter_chat/ringy/domain/entities/socket_models/file_share_response.dart';
import 'package:flutter_chat/ringy/domain/entities/socket_models/socket_delete_message.dart';
import 'package:flutter_chat/ringy/domain/entities/socket_models/socket_edit_message.dart';
import 'package:flutter_chat/ringy/domain/entities/socket_models/socket_receive_message.dart';
import 'package:flutter_chat/ringy/domain/entities/users/chatusers/users_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/encryption_utils.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';
import 'package:flutter_chat/ringy/resources/styles.dart';

import 'data_travel_model.dart';
import 'helper_class.dart';

class HelperModels {
  static ChatModel getChatModel(SocketReceiveMessage wholeJson,
      SenderId senderIdObj, SenderId receiverIdObj) {
    ChatModel chatModel = ChatModel();
    chatModel.receiverId = receiverIdObj;
    chatModel.senderId = senderIdObj;
    chatModel.message =
        EncryptData.decryptAES(wholeJson.msgData!.message!, senderIdObj.id);
    chatModel.chatType = wholeJson.msgData!.chatType;
    chatModel.messageType = wholeJson.msgData!.messageType;
    chatModel.isGroup = wholeJson.msgData!.isGroup;
    chatModel.isSeen = 0;
    chatModel.sId = wholeJson.msgData!.id;
    chatModel.receiptStatus = wholeJson.msgData!.receiptStatus;
    chatModel.createdAt = wholeJson.msgData!.createdAt;
    chatModel.isDeleted = 0;
    chatModel.projectId = Constants.projectId;
    chatModel.senderUserId = wholeJson.userId;
    return chatModel;
  }

  static Object getUpdateChatForSocket(
      UpdateMessageDataModel updateMessageDataModel) {
    var socketEditMessage = SocketEditMessage();
    var messageDataEdit = MsgDataEdit();
    messageDataEdit.message = updateMessageDataModel.msgData?.message;
    messageDataEdit.chatid = updateMessageDataModel.messageId;
    socketEditMessage.id = updateMessageDataModel.messageId;
    socketEditMessage.projectId = Constants.projectId;
    socketEditMessage.msgDataEdits = messageDataEdit;

    Object object = socketEditMessage.toJson();
    return object;
  }

  static Object getDeleteMessageForSocket(String id) {
    var socketDeleteMessage = SocketDeleteMessage();
    socketDeleteMessage.id = id;
    Object object = socketDeleteMessage.toJson();
    return object;
  }

  static Object getFileShareObjectForSocket(Object serverResponseJson) {
    Map<dynamic, dynamic> socketData =
        jsonDecode(jsonEncode(serverResponseJson));
    var fileShareResponse = FileShareResponse.fromJson(socketData);
    var socketReceiveMessage = SocketReceiveMessage();
    MsgData socketMsgData = MsgData();
    socketMsgData.createdAt =
        HelperClass.getFormatedDateWithT(DateTime.now().toString());
    socketMsgData.message = fileShareResponse.data?.message;
    socketMsgData.chatType = fileShareResponse.data?.chatType;
    socketMsgData.messageType = fileShareResponse.data?.messageType;
    socketMsgData.isGroup = fileShareResponse.data?.isGroup;
    socketMsgData.receiptStatus = fileShareResponse.data?.receiptStatus;
    socketMsgData.bookmarked = fileShareResponse.data?.bookmarked;
    socketMsgData.senderName = Prefs.getString(Prefs.myName);
    socketMsgData.senderImage = Prefs.getString(Prefs.myImage);
    SenderIds senderIds = SenderIds();
    senderIds.sId = fileShareResponse.data?.senderId;
    socketMsgData.senderId = senderIds;
    SenderIds receiverId = SenderIds();
    receiverId.sId = fileShareResponse.data?.isGroup == 0
        ? fileShareResponse.data?.receiverId
        : fileShareResponse.data?.groupId;
    socketMsgData.receiverId = receiverId;
    socketMsgData.bookmarkedChat = [];

    socketReceiveMessage.userId = fileShareResponse.data?.senderId;
    socketReceiveMessage.selectFrienddata = receiverId.sId;
    socketReceiveMessage.msgData = socketMsgData;
    Object object = socketReceiveMessage.toJson();
    return object;
  }

  static Object getSimpleMessageObjectForSocket(Object serverResponseJson) {
    Map<String, dynamic> socketData =
        jsonDecode(jsonEncode(serverResponseJson));
    var simpleMessageResponse = ChatModel.fromJson(socketData);
    var socketReceiveMessage = SocketReceiveMessage();
    MsgData socketMsgData = MsgData();
    socketMsgData.createdAt =
        HelperClass.getFormatedDateWithT(DateTime.now().toString());
    socketMsgData.message = simpleMessageResponse.message;
    socketMsgData.chatType = simpleMessageResponse.chatType;
    socketMsgData.messageType = simpleMessageResponse.messageType;
    socketMsgData.isGroup = simpleMessageResponse.isGroup;
    socketMsgData.id = simpleMessageResponse.sId;
    socketMsgData.receiptStatus = simpleMessageResponse.receiptStatus;
    socketMsgData.bookmarked = simpleMessageResponse.bookmarked;
    socketMsgData.senderName = Prefs.getString(Prefs.myName);
    socketMsgData.senderImage = Prefs.getString(Prefs.myImage);
    SenderIds senderIds = SenderIds();
    senderIds.sId = Prefs.getString(Prefs.myUserId);
    socketMsgData.senderId = senderIds;
    SenderIds receiverId = SenderIds();
    receiverId.sId = simpleMessageResponse.isGroup == 0
        ? simpleMessageResponse.receiverId?.id
        : simpleMessageResponse.groupId;
    socketMsgData.receiverId = receiverId;
    socketMsgData.bookmarkedChat = [];

    socketReceiveMessage.userId = simpleMessageResponse.senderId!.id ?? "";
    socketReceiveMessage.selectFrienddata = receiverId.sId;
    socketReceiveMessage.msgData = socketMsgData;
    Object object = socketReceiveMessage.toJson();
    return object;
  }

  static UpdateMessageDataModel editMessageModel(
      String message, String selectedMessageId) {
    MsgDataUpdate msgDataUpdate = MsgDataUpdate();
    msgDataUpdate.message = message;
    UpdateMessageDataModel updateMessageDataModel = UpdateMessageDataModel();
    updateMessageDataModel.messageId = selectedMessageId;
    updateMessageDataModel.msgData = msgDataUpdate;
    return updateMessageDataModel;
  }

  static ChatModel addDummyMessageModel(
    String message,
    int messageType,
    int isGroup,
    String receiverId,
  ) {
    SenderId receiverIdObj = SenderId();
    receiverIdObj.id = receiverId;

    SenderId senderIdObj = SenderId();
    senderIdObj.id = Prefs.getString(Prefs.myUserId);

    ChatModel chatModel = ChatModel();
    chatModel.receiverId = receiverIdObj;
    chatModel.senderId = senderIdObj;

    chatModel.message = message;

    chatModel.chatType = 0;
    chatModel.messageType = messageType;
    chatModel.isGroup = isGroup;
    chatModel.isSeen = 0;
    chatModel.receiptStatus = 1;
    chatModel.isDeleted = 0;
    chatModel.projectId = Constants.projectId;
    chatModel.isInProgress = true;
    return chatModel;
  }

  static ChatFileShareModel chatFileShareModel(
    multiFile,
    singleFile,
    filePickerResult,
    isGroup,
    int messageType,
    String receiverId,
  ) {
    ChatFileShareModel chatFileShareModel = ChatFileShareModel();
    chatFileShareModel.multipleFiles = multiFile;
    chatFileShareModel.singleFile = singleFile;
    chatFileShareModel.documentFile = filePickerResult;
    chatFileShareModel.projectId = Constants.projectId;
    chatFileShareModel.isGroup = isGroup;
    chatFileShareModel.senderId = Prefs.getString(Prefs.myUserId);
    chatFileShareModel.friendId = receiverId;
    chatFileShareModel.messageType = messageType;
    chatFileShareModel.receiptStatus = 1;
    chatFileShareModel.isFromMobile = 1;
    return chatFileShareModel;
  }

  static SendMessageDataModel sendMessageModel(
      TmpDataTravel tmpDataTravel, String message, int messageType) {
    SendMessageData msgData = SendMessageData();
    msgData.senderId = Prefs.getString(Prefs.myUserId);
    msgData.senderName = Prefs.getString(Prefs.myName);
    msgData.senderImage = Prefs.getString(Prefs.myImage);
    msgData.receiverId = tmpDataTravel.recieverId;
    msgData.receiverImage = tmpDataTravel.image;
    msgData.isGroup = tmpDataTravel.isGroup;
    msgData.message =
        EncryptData.encryptAES(message, Prefs.getString(Prefs.myUserId));
    msgData.messageType = messageType;
    msgData.chatType = 0;
    msgData.isSeen = 0;
    msgData.receiptStatus = 1;

    SendMessageDataModel sendMessageData = SendMessageDataModel();
    sendMessageData.projectId = Constants.projectId;
    sendMessageData.selectedUserData = tmpDataTravel.recieverId;
    sendMessageData.msgData = msgData;
    return sendMessageData;
  }

  static SocketReceiveMessage sendMessageToSocketModel(
      TmpDataTravel tmpDataTravel, String message) {
    SocketReceiveMessage argsSendMessageSocket = SocketReceiveMessage();

    SenderIds senderIds = SenderIds();
    senderIds.sId = Prefs.getString(Prefs.myUserId);
    SenderIds receiverIds = SenderIds();
    receiverIds.sId = tmpDataTravel.recieverId;

    MsgData socketMsgData = MsgData();
    socketMsgData.receiverImage = tmpDataTravel.image;
    socketMsgData.createdAt =
        HelperClass.getFormatedDateWithT(DateTime.now().toString());
    socketMsgData.message =
        EncryptData.encryptAES(message, Prefs.getString(Prefs.myUserId));
    socketMsgData.chatType = 0;
    socketMsgData.messageType = 0;
    socketMsgData.isGroup = tmpDataTravel.isGroup;
    socketMsgData.receiptStatus = 1;
    socketMsgData.bookmarked = 0;
    socketMsgData.senderName = Prefs.getString(Prefs.myName);
    socketMsgData.senderImage = Prefs.getString(Prefs.myImage);
    socketMsgData.senderId = senderIds;
    socketMsgData.receiverId = receiverIds;
    socketMsgData.bookmarkedChat = [];

    argsSendMessageSocket.userId = Prefs.getString(Prefs.myUserId);
    argsSendMessageSocket.selectFrienddata = tmpDataTravel.recieverId;
    argsSendMessageSocket.msgData = socketMsgData;
    argsSendMessageSocket.toJson();
    return argsSendMessageSocket;
  }

  static showActualBottom(List<Widget> items, BuildContext context) {
    FocusScope.of(context).unfocus();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        builder: (context) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: RingyStyles.decor5white,
                  margin: const EdgeInsets.all(10),
                  child: Wrap(
                    children: items,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () => {Navigator.pop(context)},
                    child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.close,
                          color: Colors.black38,
                          size: 30,
                        )),
                  ),
                )
              ],
            ));
  }

  static TmpDataTravel getUserListToTempDataTravel(
    UsersList list,
  ) {
    var tmpDataTravel = TmpDataTravel();
    tmpDataTravel.recieverId = list.sId!;
    tmpDataTravel.image = list.userImage!;

    return tmpDataTravel;
  }
}
