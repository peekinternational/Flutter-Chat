import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_chat/ringy/domain/entities/authentication/login_response.dart';
import 'package:flutter_chat/ringy/domain/entities/authentication/register_response.dart';
import 'package:flutter_chat/ringy/domain/entities/chat/chal_file_share.dart';
import 'package:flutter_chat/ringy/domain/entities/chat/chat_message.dart';
import 'package:flutter_chat/ringy/domain/entities/chat/send_message_api.dart';
import 'package:flutter_chat/ringy/domain/entities/chat/update_chat_api.dart';
import 'package:flutter_chat/ringy/domain/entities/group/group_data.dart';
import 'package:flutter_chat/ringy/domain/entities/users/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/domain/entities/users/groupListModel/group_list_model.dart';
import 'package:flutter_chat/ringy/domain/i_facade.dart';
import 'package:flutter_chat/ringy/infrastructure/API/api_content.dart';
import 'package:flutter_chat/ringy/infrastructure/API/dio_client.dart';
import 'package:flutter_chat/ringy/presentation/core/socket/users_socket_utils.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/helper_class.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/helper_models.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/socket_helper.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as htp;

class ApiDataSource implements IFacade {
  Dio dio = DioClient.instance.getDioClient();
  final _socketProvider = SocketProviderUsers();

  @override
  Future<Either<String, List<ChatModel>>> getChats(
      String senderId, String receiverId, String limit, int isGroup) async {
    try {
      String url = "";
      if (isGroup == 0) {
        url = APIContent.o2oChatFetchURL +
            "/" +
            senderId +
            "/" +
            receiverId +
            "/" +
            limit +
            "/" +
            Constants.projectId +
            "/0";
      } else {
        url = APIContent.groupChatFetchURL +
            "/" +
            receiverId +
            "/" +
            senderId +
            "/0/" +
            Constants.projectId;
      }
      Response response;
      response = await dio.get(url);
      Iterable jsonChat = response.data;
      return right(jsonChat.map((user) => ChatModel.fromJson(user)).toList());
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, SendMessageDataModel>> sendMessage(
      SendMessageDataModel model) async {
    try {
      String uri = APIContent.chatSendURL;
      String json = jsonEncode(model.toJson());
      Response response;
      response = await dio.post(uri, data: json);
      if (response.statusCode == 200) {
        _socketProvider.getSocket();
        _socketProvider.mSocketEmit(SocketHelper.singleSendMessage,
            HelperModels.getSimpleMessageObjectForSocket(response.data));

        try {
          String? token = await HelperClass.getFcmToken();
          String serverKey = "AAAAppB7FUY:APA91bEUAh0qO5HmqrbqlJVn7_ksopHbReSZlblHqd1wGIm5ESCRuEErtQhzb-riKjQWqlCMwDDj-HaGmowHRy72IYgkDV36ih2CugCYv_Uaml7dhxinJr2jtM1k1jRBxvFpBlq9No4u";

          await htp.post(
            Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'key=$serverKey',
            },
            body: HelperClass.constructFCMPayload([token!,token], Prefs.getString(Prefs.myName) ?? "new message", model.msgData!.message ?? "body"),
          );
          print('FCM request for device sent!');
        } catch (e) {
          print(e);
        }
      }

      return right(model);
    } catch (e) {
      print(e.toString());
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> sendGroupMessage(
    String groupId,
    String senderId,
    String message,
    int messageType,
  ) async {
    try {
      String uri = APIContent.groupChatSendURL;
      Response response;
      response = await dio.post(uri, data: {
        'chatType': 0,
        'groupId': groupId,
        'senderId': senderId,
        'message': message,
        'messageType': messageType,
        'isGroup': 1,
        'projectId': Constants.projectId,
      });
      if (response.statusCode == 200) {
        _socketProvider.getSocket();
        print(
            "222222222222222222222222222222 ggggggggrrrrrrrppp: ${response.data}");
        _socketProvider.mSocketEmit(SocketHelper.emitGroupMessage,
            HelperModels.getSimpleMessageObjectForSocket(response.data));
      }

      return right(response.statusCode.toString());
    } catch (e) {
      print(e.toString());
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, UpdateMessageDataModel>> updateMessage(
      UpdateMessageDataModel model) async {
    try {
      _socketProvider.getSocket();
      _socketProvider.mSocketEmit(SocketHelper.emitUpdateChat,
          HelperModels.getUpdateChatForSocket(model));
      String uri = APIContent.updateMessageURL;
      String json = jsonEncode(model.toJson());

      Response response;
      response = await dio.post(uri, data: json);

      print(response.data);
      return right(model);
    } catch (e) {
      print(e.toString());
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteMessage(
      String messageId, String type) async {
    try {
      _socketProvider.getSocket();
      _socketProvider.mSocketEmit(SocketHelper.emitDeleteMessage,
          HelperModels.getDeleteMessageForSocket(messageId));

      String url = APIContent.deleteMessageURL +
          "/" +
          messageId +
          "/" +
          type +
          "/" +
          Constants.projectId;

      Response response;
      response = await dio.get(url);

      print(response.data);
      return response.statusCode == 200
          ? right(response.data)
          : left(response.data);
    } catch (e) {
      print(e.toString());
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, ChatFileShareModel>> chatFileShare(
      ChatFileShareModel model) async {
    try {
      var formData = FormData.fromMap({
        'senderId': model.senderId,
        'messageType': model.messageType,
        'isGroup': model.isGroup,
        'isFromMobile': model.isFromMobile,
        'receiptStatus': model.receiptStatus,
        'projectId': model.projectId,
      });
      model.isGroup == 0
          ? formData.fields.add(MapEntry('friendId', model.friendId!))
          : formData.fields.add(MapEntry('groupId', model.friendId!));

      if (model.multipleFiles != null) {
        for (var item in model.multipleFiles!) {
          formData.files.addAll([
            MapEntry("file", await MultipartFile.fromFile(item.path)),
          ]);
        }
      } else if (model.singleFile != null) {
        formData.files.addAll([
          MapEntry(
              "file", await MultipartFile.fromFile(model.singleFile!.path)),
        ]);
      } else {
        formData.files.addAll([
          MapEntry(
              "file",
              await MultipartFile.fromFile(
                  model.documentFile!.files.single.path!)),
        ]);
      }

      var response = await dio.post(APIContent.chatFileShareURL,
          data: formData, onSendProgress: (int sent, int total) {});
      if (response.statusCode == 200) {
        _socketProvider.getSocket();
        if (model.isGroup == 0) {
          _socketProvider.mSocketEmit(SocketHelper.singleSendMessage,
              HelperModels.getFileShareObjectForSocket(response.data));
        } else {
          print('nnnnnnnnnneeeeeeqqq: ${response.data}');
          _socketProvider.mSocketEmit(SocketHelper.emitGroupMessage,
              HelperModels.getFileShareObjectForSocket(response.data));
        }
      }
      return right(model);
    } on DioError catch (e) {
      print(e);
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<UsersList>>> getUsersList(
      String projectId, String uID) async {
    // @GET("/{url}/{uID}/{pId}/0/0/0")
    try {
      String url = APIContent.getO2oUsersURL + "/" + uID + "/0/" + projectId;

      Response response = await dio.get(url);
      print(response.data);
      Iterable jsonChat = response.data["usersList"];
      print(jsonChat);
      List<UsersList> list = [];
      for (final element in jsonChat) {
        try {
          print(element);
          LatestMsg? latestMsg;
          latestMsg = element['latestMsg']["_id"] != null
              ? LatestMsg.fromJson(element['latestMsg'])
              : null;

          UsersList model = UsersList.fromJson(element);
          model.name == "" ? model.name = "No Name" : model.name = model.name;
          if (latestMsg != null) {
            model.latestMsg = latestMsg.message;
            model.latestMsgType = latestMsg.messageType;
            model.latestMsgCreatedAt = latestMsg.createdAt;
            model.latestMsgSenderId = latestMsg.senderId;
          }
          list.add(model);
          print(list);
        } catch (e) {
          print(e);
        }
      }
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<GroupList>>> getGroupsList(
      String projectId, String uID) async {
    try {
      String url = APIContent.getGroupsURL + "/" + uID + "/" + projectId;

      Response response = await dio.get(url);
      print(response.data);
      Iterable jsonChat = response.data;
      List<GroupList> list = [];
      for (final element in jsonChat) {
        try {
          print(element);
          LatestMsg? latestMsg;
          latestMsg = element['latestMsg'] != null
              ? LatestMsg.fromJson(element['latestMsg'])
              : null;

          GroupList model = GroupList.fromJson(element);
          model.name == "" ? model.name = "No Name" : model.name = model.name;
          if (latestMsg != null) {
            model.latestMsg = latestMsg.message;
            model.latestMsgType = latestMsg.messageType;
            model.latestMsgCreatedAt = latestMsg.createdAt;
            model.latestMsgSenderId = latestMsg.senderId;
          }
          list.add(model);
        } catch (e) {
          print(e);
        }
      }
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> registerUser(
    String email,
    String phone,
    String name,
    String userId,
    String password,
  ) async {
    try {
      String uri = APIContent.registerUserURL;
      Response response;
      response = await dio.post(uri, data: {
        APIContent.projectId: Constants.projectId,
        APIContent.email: email,
        if (phone != "") APIContent.mobile: phone,
        if (name != "") APIContent.name: name,
        if (userId != "") APIContent.userId: userId,
        APIContent.password: password
      });
      String code = Register.fromJson(response.data).status.toString();
      return right(code);
    } catch (e) {
      print(e.toString());
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> loginUser(
    String email,
    String password,
  ) async {
    try {
      String uri = APIContent.loginUserURL;
      var datae = {
        APIContent.projectId: Constants.projectId,
        APIContent.email: email,
        APIContent.password: password,
        APIContent.fcmToken: await HelperClass.getFcmToken(),
      };
      Response response;
      response = await dio.post(uri, data: datae);

      print(datae.toString());
      String code =
          LoginResponse.fromJson(response.data).isUserExist.toString();

      if (code == "true") {
        print(response.data);
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        Prefs.setString(Prefs.myUserId, loginResponse.data!.id!);
        Prefs.setString(Prefs.myName, loginResponse.data!.name!);
        Prefs.setString(Prefs.myImage, loginResponse.imageFile!);
        Prefs.setString(Prefs.myMail, loginResponse.data!.email!);
      }
      return right(code);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> createGroup(
    String groupName,
    List<UsersList> mListSelected,
    String iconPath,
  ) async {
    try {
      List<String> members = [];
      for (var item in mListSelected) {
        members.add(item.sId!);
      }
      GroupData groupData = GroupData();
      groupData.name = groupName;
      groupData.projectId = Constants.projectId;
      groupData.status = 1;
      groupData.creatorUserId = Prefs.getString(Prefs.myUserId);
      groupData.members = members;
      if (iconPath != "") {
        groupData.groupImage = basename(iconPath);
      }

      Object object = groupData.toJson();
      var postData = {
        'userId': Prefs.getString(Prefs.myUserId),
        'groupData': json.encode(object),
      };

      var formData = FormData.fromMap({
        'userId': Prefs.getString(Prefs.myUserId),
        'groupData': json.encode(object),
      });
      if (iconPath != "") {
        formData.files.addAll([
          MapEntry("file", await MultipartFile.fromFile(iconPath)),
        ]);
      }
      print(json.encode(object));
      var response = await dio.post(APIContent.createGroup,
          data: iconPath == "" ? postData : formData,
          onSendProgress: (int sent, int total) {});

      if (response.statusCode == 200) {
        return right("");
      } else {
        return left(response.data);
      }
    } catch (e) {
      print(e.toString());
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> changeProfile(
      String textName, String textIcon, String textEmail) async {
    try {
      var formData = FormData.fromMap({
        'userId': Prefs.getString(Prefs.myUserId),
        'name': textName,
        if (textIcon != Prefs.getString(Prefs.myImage))
          'imageName': basename(textIcon),
        'newEmail': textEmail,
        'oldEmail': Prefs.getString(Prefs.myMail),
        'projectId': Constants.projectId,
      });
      if (textIcon != "" && textIcon != Prefs.getString(Prefs.myImage)) {
        formData.files.addAll([
          MapEntry("file", await MultipartFile.fromFile(textIcon)),
        ]);
      }
      var response = await dio.post(APIContent.updateUserProfile,
          data: formData, onSendProgress: (int sent, int total) {});

      print(response.data);

      if (response.statusCode == 200) {
        Prefs.setString(Prefs.myName, textName);
        if (textIcon != Prefs.getString(Prefs.myImage)) {
          Prefs.setString(Prefs.myImage, basename(textIcon));
        }
        Prefs.setString(Prefs.myMail, textEmail);
        return right("");
      } else {
        return left(response.data);
      }
    } catch (e) {
      print(e.toString());
      return left(e.toString());
    }
  }

  Future<void> userOnlineStatus(String? userId, int pStatus) async {
    try {
      String uri = APIContent.userOnlineStatusURL;
      Response response = await dio.post(uri, data: {
        APIContent.projectId: Constants.projectId,
        APIContent.userId: userId,
        APIContent.onlineStatus: pStatus
      });
    } catch (e) {
      print(e);
    }
  }
}
