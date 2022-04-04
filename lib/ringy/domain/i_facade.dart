import 'package:dartz/dartz.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chal_file_share.dart';
import 'package:flutter_chat/ringy/domain/entities/connect/get_user_ring.dart';

import 'entities/chat_message/chat_message.dart';
import 'entities/chat_message/chatusers/users_model.dart';
import 'entities/chat_message/send_message_api.dart';
import 'entities/chat_message/update_chat_api.dart';

abstract class IFacade{
  Future<Either<String,List<ChatModel>>> getChats(String senderId, String receiverId ,String limit);
  Future<Either<String,List<UsersList>>> getUsersList(String projectId,String userId);
  Future<Either<String,SendMessageDataModel>> sendMessage(SendMessageDataModel model);
  Future<Either<String,ChatFileShareModel>> chatFileShare(ChatFileShareModel model);
  Future<Either<String,UpdateMessageDataModel>> updateMessage(UpdateMessageDataModel model);
  Future<Either<String,String>> deleteMessage(String messageId,String type);
  Future<Either<String,List<GetUserRingModel>>> getRingList(String projectId,String userId);
  Future<Either<String,String>> registerUser(String email,String phone,String name,String userId,String password);
  Future<Either<String,String>> loginUser(String email,String password);
}