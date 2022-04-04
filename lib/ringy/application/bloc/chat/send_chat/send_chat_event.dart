part of 'send_chat_bloc.dart';

@immutable
abstract class SendChatEvent {}
class SendChatsEvent extends SendChatEvent{

  final SendMessageDataModel model;

  SendChatsEvent(this.model);
}
class ShareFileEvent extends SendChatEvent{

  final ChatFileShareModel model;

  ShareFileEvent(this.model);
}
class UpdateMessageEvent extends SendChatEvent{

  final UpdateMessageDataModel model;

  UpdateMessageEvent(this.model);
}
