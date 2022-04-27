import 'package:dartz/dartz.dart';

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
      SendMessageDataModel model);

  Future<Either<String, String>> sendGroupMessage(
      String groupId, String senderId, String message, int messageType);

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
}
