import 'package:dartz/dartz.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chal_file_share.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chat_message.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/send_message_api.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/update_chat_api.dart';
import 'package:flutter_chat/ringy/domain/entities/connect/get_user_ring.dart';
import 'package:flutter_chat/ringy/domain/i_facade.dart';

import 'data_sources/api_data_source.dart';

class Repository implements IFacade {
  final ApiDataSource apiDataSource;

  Repository({required this.apiDataSource});

  @override
  Future<Either<String, List<ChatModel>>> getChats(
      String senderId, String receiverId, String limit) {
    return apiDataSource.getChats(senderId, receiverId, limit);
  }

  @override
  Future<Either<String, SendMessageDataModel>> sendMessage(SendMessageDataModel model) {
    return apiDataSource.sendMessage(model);
  }
  @override
  Future<Either<String, ChatFileShareModel>> chatFileShare(ChatFileShareModel model) {
    return apiDataSource.chatFileShare(model);
  }
  @override
  Future<Either<String, UpdateMessageDataModel>> updateMessage(UpdateMessageDataModel model) {
    return apiDataSource.updateMessage(model);
  }

  @override
  Future<Either<String, String>> deleteMessage(
      String messageId,String type) {
    return apiDataSource.deleteMessage(messageId,type);
  }

  @override
  Future<Either<String, List<GetUserRingModel>>> getRingList(
      String projectId, String user_id) {
    return apiDataSource.getRingList(projectId, user_id);
  }

  @override
  Future<Either<String, List<UsersList>>> getUsersList(
      String projectId, String userId) {
    return apiDataSource.getUsersList(projectId, userId);
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

}
