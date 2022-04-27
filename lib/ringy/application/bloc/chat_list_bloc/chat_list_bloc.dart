import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/ringy/domain/entities/chat/chat_message.dart';
import 'package:flutter_chat/ringy/domain/entities/socket_models/socket_delete_message.dart';
import 'package:flutter_chat/ringy/domain/entities/socket_models/socket_edit_message.dart';
import 'package:flutter_chat/ringy/domain/entities/socket_models/socket_online_status.dart';
import 'package:flutter_chat/ringy/domain/entities/socket_models/socket_receive_message.dart';
import 'package:flutter_chat/ringy/domain/entities/socket_models/typing.dart';
import 'package:flutter_chat/ringy/infrastructure/_repository.dart';
import 'package:flutter_chat/ringy/presentation/core/socket/users_socket_utils.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/helper_class.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/helper_models.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/message_enum.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/socket_helper.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:meta/meta.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState>
    implements SocketEventsChat {
  final Repository repository;

  // final SocketProviderUsers _socketProvider = SocketProviderUsers.instance;
  final _socketProvider = SocketProviderUsers();
  List<ChatModel> dummyList = [];
  String openedChatUserId = "";
  int isGroup = 0;

  ChatListBloc(this.repository) : super(ChatListInitial()) {
    on<GetChatsEvent>(_onEvent, transformer: sequential());
    on<UpdateChatsEvent>(_onEventUpdate, transformer: sequential());
    on<TypingEvent>(_onTypingEvent, transformer: sequential());
  }

  FutureOr<void> _onEvent(
      GetChatsEvent event, Emitter<ChatListState> emit) async {
    emit(ChatsLoadingState());
    _socketProvider.setEventListenerChat(this);
    _socketProvider.getSocket();
    openedChatUserId = event.receiverId;
    isGroup = event.isGroup;
    var result = await repository.getChats(
        event.senderId, event.receiverId, event.limit, event.isGroup);
    result.fold((l) => emit(ChatListErrorState()), (r) => getChatList(r, emit));
  }

  FutureOr<void> _onEventUpdate(
      UpdateChatsEvent event, Emitter<ChatListState> emit) async {
    if (event.args == null) {
      dummyList = event.chats;
      emit(ChatListLoadedState(chats: dummyList));
    } else {
      Object object = event.args!.toJson();
      _socketProvider.mSocketEmit(SocketHelper.singleSendMessage, object);
    }
  }

  FutureOr<void> _onTypingEvent(
      TypingEvent event, Emitter<ChatListState> emit) async {
    var socketTyping = SocketTyping();
    socketTyping.userId = event.socketTyping.userId;
    socketTyping.selectFrienddata = event.socketTyping.selectFrienddata;
    Object startTypingObject = socketTyping.toJson();

    if (event.isTyping && isGroup != 1) {
      _socketProvider.mSocketEmit(
          SocketHelper.emitStartMsgTyping, startTypingObject);
      Future.delayed(const Duration(milliseconds: 1200), () {
        socketTyping.lastmsg = dummyList[dummyList.length - 1].message;
        Object stopTypingObject = socketTyping.toJson();
        _socketProvider.mSocketEmit(
            SocketHelper.emitStopMsgTyping, stopTypingObject);
      });
    }
  }

  getChatList(List<ChatModel> r, Emitter<ChatListState> emit) {
    dummyList = r;
    emit(ChatListLoadedState(chats: r));
  }

  // Listen To Events For Socket
  @override
  void eventListener(String eventName, Object args) {
    if (eventName == SocketHelper.singleMessageReceived || eventName == SocketHelper.onGroupMessageReceived) {
      newMessageReceived(args);
    } else if (eventName == SocketHelper.onStartMsgTyping) {
      typing(args, true);
    } else if (eventName == SocketHelper.onStopMsgTyping) {
      typing(args, false);
    } else if (eventName == SocketHelper.onOnlineStatus) {
      onlineStatus(args);
    } else if (eventName == SocketHelper.onUpdateChat) {
      updateMessage(args);
    } else if (eventName == SocketHelper.onDeleteMessage) {
      deleteMessage(args);
    }
  }

  void newMessageReceived(Object args) {

    print("valllllll:::::::::::::: $args");
    Map<dynamic, dynamic> socketData = jsonDecode(jsonEncode(args));
    var wholeJson = SocketReceiveMessage.fromJson(socketData);
    SenderId receiverIdObj = SenderId();
    receiverIdObj.id = wholeJson.msgData!.receiverId?.sId!;
    SenderId senderIdObj = SenderId();
    senderIdObj.id = wholeJson.msgData!.senderId?.sId!;
    var whom = HelperClass.isMessageForMe(receiverIdObj.id!, senderIdObj.id!,openedChatUserId);

    switch(whom){
      case Whom.iAmSender:
        break;
      case Whom.iAmReceiver:
        break;
      case Whom.iAmForwarded:
        return;
        break;
      case Whom.notForMe:
        return;
        break;
    }


    dummyList.removeWhere((item) => item.isInProgress == true);
    dummyList
        .add(HelperModels.getChatModel(wholeJson, senderIdObj, receiverIdObj));
    emit(ChatListLoadedState(chats: dummyList));
  }

  void typing(Object args, bool isTyping) {
    Map<dynamic, dynamic> socketData = jsonDecode(jsonEncode(args));
    var wholeJson = SocketTyping.fromJson(socketData);
    if (wholeJson.selectFrienddata == Prefs.getString(Prefs.myUserId) &&
        wholeJson.userId == openedChatUserId) {
      if (isTyping) {
        emit(AppBarRefreshState(false, isTyping, 0));
        return;
      } else {
        emit(AppBarRefreshState(false, isTyping, 0));
        return;
      }
    }
  }

  //Recheck (rebuild will take old value so update it)
  void onlineStatus(Object args) {
    Map<dynamic, dynamic> socketData = jsonDecode(jsonEncode(args));
    var wholeJson = SocketOnlineStatus.fromJson(socketData);
    if (wholeJson.userId == openedChatUserId) {
      emit(AppBarRefreshState(true, false, wholeJson.status!));
      return;
    }
  }

  void updateMessage(Object args) {
    Map<String, dynamic> socketData = jsonDecode(jsonEncode(args));
    var wholeJson = SocketEditMessage.fromJson(socketData);
    dummyList[dummyList
        .indexWhere((element) => element.sId == wholeJson.id)]
        .message = wholeJson.msgDataEdits?.message;
    emit(ChatListLoadedState(chats: dummyList));
  }
  void deleteMessage(Object args) {
    Map<String, dynamic> socketData = jsonDecode(jsonEncode(args));
    var wholeJson = SocketDeleteMessage.fromJson(socketData);
    dummyList[dummyList
        .indexWhere((element) => element.sId == wholeJson.id)]
        .isDeleted = 1;
    emit(ChatListLoadedState(chats: dummyList));
  }

}


