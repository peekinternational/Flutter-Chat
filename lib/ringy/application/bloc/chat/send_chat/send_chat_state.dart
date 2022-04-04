part of 'send_chat_bloc.dart';

@immutable
abstract class SendChatState {}

class SendChatInitial extends SendChatState {}

class LoadedState extends SendChatState{
  final SendMessageDataModel chats;
  LoadedState({required this.chats});
}
class LoadedShareChatState extends SendChatState{
  final ChatFileShareModel chats;
  LoadedShareChatState({required this.chats});
}
class LoadedUpdateChatState extends SendChatState{
  final UpdateMessageDataModel chats;
  LoadedUpdateChatState({required this.chats});
}

class ErrorState extends SendChatState{

}
class LoadingState extends SendChatState{}
