import 'package:dartz/dartz.dart';
import 'package:flutter_chat/ringy/domain/entities/add_friends/friend_requests.dart';
import 'package:flutter_chat/ringy/domain/entities/add_friends/searched_users.dart';
import 'package:flutter_chat/ringy/domain/entities/chat/chal_file_share.dart';
import 'package:flutter_chat/ringy/domain/entities/chat/chat_message.dart';
import 'package:flutter_chat/ringy/domain/entities/chat/send_message_api.dart';
import 'package:flutter_chat/ringy/domain/entities/chat/update_chat_api.dart';
import 'package:flutter_chat/ringy/domain/entities/users/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/domain/entities/users/groupListModel/group_list_model.dart';
import 'package:flutter_chat/ringy/domain/i_facade.dart';

import '../presentation/core/utils/data_travel_model.dart';
import 'data_sources/api_data_source.dart';

class Repository implements IFacade {
  final ApiDataSource apiDataSource;

  Repository({required this.apiDataSource});

  @override
  Future<Either<String, List<ChatModel>>> getChats(
      String senderId, String receiverId, String limit, int isGroup) {
    return apiDataSource.getChats(senderId, receiverId, limit, isGroup);
  }

  @override
  Future<Either<String, SendMessageDataModel>> sendMessage(
      SendMessageDataModel model,TmpDataTravel tmpDataTravel) {
    return apiDataSource.sendMessage(model,tmpDataTravel);
  }

  @override
  Future<Either<String, String>> sendGroupMessage(
    String groupId,
    String senderId,
    String message,
    int messageType,
  TmpDataTravel tmpDataTravel
  ) {
    return apiDataSource.sendGroupMessage(
      groupId,
      senderId,
      message,
      messageType,
      tmpDataTravel
    );
  }

  @override
  Future<Either<String, ChatFileShareModel>> chatFileShare(
      ChatFileShareModel model) {
    return apiDataSource.chatFileShare(model);
  }

  @override
  Future<Either<String, UpdateMessageDataModel>> updateMessage(
      UpdateMessageDataModel model) {
    return apiDataSource.updateMessage(model);
  }

  @override
  Future<Either<String, String>> deleteMessage(String messageId, String type) {
    return apiDataSource.deleteMessage(messageId, type);
  }

  @override
  Future<Either<String, List<UsersList>>> getUsersList(
      String projectId, String userId) {
    return apiDataSource.getUsersList(projectId, userId);
  }

  @override
  Future<Either<String, List<GroupList>>> getGroupsList(
      String projectId, String userId) {
    return apiDataSource.getGroupsList(projectId, userId);
  }

  @override
  Future<Either<String, String>> registerUser(
    String email,
    String phone,
    String name,
    String userId,
    String password,
  ) {
    return apiDataSource.registerUser(email, phone, name, userId, password);
  }

  @override
  Future<Either<String, String>> loginUser(
    String email,
    String password,
  ) {
    return apiDataSource.loginUser(email, password);
  }

  @override
  Future<Either<String, String>> createGroup(
    String groupName,
    List<UsersList> mListSelected,
      String iconPath,
  ) {
    return apiDataSource.createGroup(groupName, mListSelected,iconPath);
  }

  @override
  Future<Either<String, String>> changeProfile(
      String textName,String textIcon,String textEmail
  ) {
    return apiDataSource.changeProfile(textName, textIcon,textEmail);
  }

  @override
  Future<Either<String, List<Datum>>> searchUser(
      String userId,String nameText
  ) {
    return apiDataSource.searchUser(userId, nameText);
  }

  @override
  Future<Either<String, String>> sendFriendRequest(
      String userId,String friendId
  ) {
    return apiDataSource.sendFriendRequest(userId, friendId);
  }

  @override
  Future<Either<String, List<FriendRequests>>> getFriendRequests(String userId) {
    return apiDataSource.getFriendRequests(userId);
  }
}
