part of 'chat_list_bloc.dart';

@immutable
abstract class ChatListState {}

class ChatListInitial extends ChatListState {}


class ChatListLoadedState extends ChatListState{
  final List<ChatModel> chats;

  ChatListLoadedState({required this.chats});

}

class ChatListErrorState extends ChatListState{
  
}
class ChatsLoadingState extends ChatListState{}

class AppBarRefreshState extends ChatListState{
  final bool isOnlineSocketHit;
  final bool isTyping;
  final int isOnline;

  AppBarRefreshState(this.isOnlineSocketHit, this.isTyping, this.isOnline);
}