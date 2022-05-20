import 'package:dartz/dartz.dart';
import 'package:flutter_chat/ringy/domain/entities/add_friends/friend_requests.dart';

import '../presentation/core/utils/data_travel_model.dart';
import 'entities/add_friends/searched_users.dart';
import 'entities/chat/chal_file_share.dart';
import 'entities/chat/chat_message.dart';
import 'entities/chat/send_message_api.dart';
import 'entities/chat/update_chat_api.dart';
import 'entities/users/chatusers/users_model.dart';
import 'entities/users/groupListModel/group_list_model.dart';

abstract class IFacade {
  Future<Either<String, List<ChatModel>>> getChats(
      String senderId, String receiverId, String limit, int isGroup);

  Future<Either<String, List<UsersList>>> getUsersList(
      String projectId, String userId);

  Future<Either<String, List<GroupList>>> getGroupsList(
      String projectId, String userId);

  Future<Either<String, SendMessageDataModel>> sendMessage(
      SendMessageDataModel model,TmpDataTravel tmpDataTravel);

  Future<Either<String, String>> sendGroupMessage(
      String groupId, String senderId, String message, int messageType,
  TmpDataTravel tmpDataTravel);

  Future<Either<String, ChatFileShareModel>> chatFileShare(
      ChatFileShareModel model);

  Future<Either<String, UpdateMessageDataModel>> updateMessage(
      UpdateMessageDataModel model);

  Future<Either<String, String>> deleteMessage(String messageId, String type);

  Future<Either<String, String>> registerUser(
      String email, String phone, String name, String userId, String password);

  Future<Either<String, String>> loginUser(String email, String password);

  Future<Either<String, String>> createGroup(
      String groupName, List<UsersList> mListSelected, String iconPath);

  Future<Either<String, String>> changeProfile(
      String textName,String textIcon,String textEmail);

  Future<Either<String, List<Datum>>> searchUser(String userId,
      String textName);

  Future<Either<String, String>> sendFriendRequest(String userId,
      String friendId);

  Future<Either<String, List<FriendRequests>>> getFriendRequests(String userId);
}
