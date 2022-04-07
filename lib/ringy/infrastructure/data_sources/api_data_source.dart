import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_chat/ringy/domain/entities/authentication/login_response.dart';
import 'package:flutter_chat/ringy/domain/entities/authentication/register_response.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chal_file_share.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chat_message.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/send_message_api.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/update_chat_api.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/user_model.dart';
import 'package:flutter_chat/ringy/domain/i_facade.dart';
import 'package:flutter_chat/ringy/infrastructure/API/api_content.dart';
import 'package:flutter_chat/ringy/infrastructure/API/dio_client.dart';
import 'package:flutter_chat/ringy/presentation/core/socket/users_socket_utils.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/helper_models.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/socket_helper.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';

import '../../domain/entities/connect/get_user_ring.dart';

class ApiDataSource implements IFacade{
  Dio dio = DioClient.instance.getDioClient();
  final _socketProvider = SocketProviderUsers();
  @override
  Future<Either<String, List<ChatModel>>> getChats(String senderId,
      String receiverId, String limit) async {
    try {
      String url = APIContent.o2oChatFetchURL +
          "/" +
          senderId +
          "/" +
          receiverId +
          "/" +
          limit +
          "/" +
          Constants.projectId +
          "/0";

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
      print(json);
      Response response;
      response = await dio.post(uri, data: json);
      if(response.statusCode == 200){
        _socketProvider.getSocket();
        _socketProvider.mSocketEmit(SocketHelper.singleSendMessage, HelperModels.getSimpleMessageObjectForSocket(response.data));
      }

      return right(model);
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
      _socketProvider.mSocketEmit(SocketHelper.emitUpdateChat, HelperModels.getUpdateChatForSocket(model));
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
      String messageId,String type) async {
    try {
      _socketProvider.getSocket();
      _socketProvider.mSocketEmit(SocketHelper.emitDeleteMessage, HelperModels.getDeleteMessageForSocket(messageId));

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
      return response.statusCode == 200 ? right(response.data) : left(response.data);
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
        'friendId': model.friendId,
        'messageType': model.messageType,
        'isGroup': model.isGroup,
        'isFromMobile': model.isFromMobile,
        'receiptStatus': model.receiptStatus,
        'projectId': model.projectId,
      });



     if(model.multipleFiles != null){
       for (var item in  model.multipleFiles!) {
         formData.files.addAll([
           MapEntry("file", await MultipartFile.fromFile(item.path)),
         ]);
       }
     } else if(model.singleFile !=null){
       formData.files.addAll([
         MapEntry("file", await MultipartFile.fromFile(model.singleFile!.path)),
       ]);
     }else{
       formData.files.addAll([
         MapEntry("file", await MultipartFile.fromFile(model.documentFile!.files.single.path!)),
       ]);
     }
      var response = await dio.post(APIContent.chatFileShareURL, data: formData,onSendProgress: (int sent, int total) {
        print('$sent $total');
      });
     if(response.statusCode == 200){
       _socketProvider.getSocket();
       _socketProvider.mSocketEmit(SocketHelper.singleSendMessage, HelperModels.getFileShareObjectForSocket(response.data));
     }
      return right(model);
    } on DioError catch (e) {
      print(e);
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<GetUserRingModel>>> getRingList(String projectId,
      String user_id) async {
    try {
      Response response;
      response = await dio.post(APIContent.getUserRing,
          data: {APIContent.projectId: projectId, APIContent.userId: user_id});
      Iterable jsonChat = response.data["ringData"];
      return right(
          jsonChat.map((user) => GetUserRingModel.fromJson(user)).toList());
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<UsersList>>> getUsersList(String projectId,
      String uID) async {
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
  Future<Either<String, String>> registerUser(String email,
      String phone,
      String name,
      String userId,
      String password,) async {
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
      String code = Register
          .fromJson(response.data)
          .status
          .toString();
      return right(code);
    } catch (e) {
      print(e.toString());
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> loginUser(String email,
      String password,) async {
    try {
      String uri = APIContent.loginUserURL;
      Response response;
      response = await dio.post(uri, data: {
        APIContent.projectId: Constants.projectId,
        APIContent.email: email,
        APIContent.password: password
      });
      String code =
      LoginResponse
          .fromJson(response.data)
          .isUserExist
          .toString();

      if (code == "true") {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        Prefs.setString(Prefs.myUserId, loginResponse.data!.id!);
        Prefs.setString(Prefs.myName, loginResponse.data!.name!);
        Prefs.setString(Prefs.myImage, loginResponse.imageFile!);
        Prefs.setString(Prefs.myMail, loginResponse.data!.email!);
      }
      return right(code);
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
