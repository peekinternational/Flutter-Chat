import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chat_message.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/socket_models/socket_online_status.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/socket_models/socket_receive_message.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/socket_models/typing.dart';
import 'package:flutter_chat/ringy/infrastructure/_repository.dart';
import 'package:flutter_chat/ringy/presentation/core/socket/users_socket_utils.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/helper_class.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/message_enum.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/socket_helper.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/encryption_utils.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';

part 'user_list_event.dart';

part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState>
    implements SocketEventsUsers {
  final Repository repository;
  List<UsersList> dummyList = [];
  final _socketProvider = SocketProviderUsers();

  UserListBloc(this.repository) : super(UserListInitial()) {
    on<GetUsersEvent>(_onEvent, transformer: sequential());
  }

  FutureOr<void> _onEvent(
      GetUsersEvent event, Emitter<UserListState> emit) async {
    emit(LoadingState());
    if (!event.showUsers) {
      _socketProvider.setEventListener(this);
      _socketProvider.getSocket();
      _socketProvider.mSocketOn(SocketHelper.singleMessageReceived);
      _socketProvider.mSocketOn(SocketHelper.onStartMsgTyping);
      _socketProvider.mSocketOn(SocketHelper.onStopMsgTyping);
      _socketProvider.mSocketOn(SocketHelper.onOnlineStatus);
      _socketProvider.mSocketOn(SocketHelper.onUpdateChat);
      _socketProvider.mSocketOn(SocketHelper.onDeleteMessage);
    }
    var result = await repository.getUsersList(event.projectId, event.userId);
    result.fold((l) => emit(ErrorState()), (r) => checkUsersCount(r, emit));
  }

  checkUsersCount(List<UsersList> r, Emitter<UserListState> emit) {
    dummyList = r;
    r.isNotEmpty ? emit(LoadedState(users: r)) : emit(NoUsersState());
  }

  @override
  void eventListener(String eventName, Object args) {
    if (eventName == SocketHelper.singleMessageReceived) {
      newMessageReceived(args);
    } else if (eventName == SocketHelper.onStartMsgTyping) {
      typing(args, true);
    } else if (eventName == SocketHelper.onStopMsgTyping) {
      typing(args, false);
    } else if (eventName == SocketHelper.onOnlineStatus) {
      changeOnlineStatus(args);
    }
  }

  void newMessageReceived(Object args) {
    Map<dynamic, dynamic> socketData = jsonDecode(jsonEncode(args));
    var wholeJson = SocketReceiveMessage.fromJson(socketData);
    SenderId receiverIdObj = SenderId();
    receiverIdObj.id = wholeJson.msgData!.receiverId?.sId!;
    SenderId senderIdObj = SenderId();
    senderIdObj.id = wholeJson.msgData!.senderId?.sId!;

    var whom =
        HelperClass.isMessageForMe(receiverIdObj.id!, senderIdObj.id!, "");
    switch (whom) {
      case Whom.iAmSender:
        break;
      case Whom.iAmReceiver:
        break;
      case Whom.iAmForwarded:
        break;
      case Whom.notForMe:
        return;
        break;
    }

    for (var i = 0; i < dummyList.length; i++) {
      if (dummyList[i].sId == senderIdObj.id) {
        dummyList[dummyList
                    .indexWhere((element) => element.sId == senderIdObj.id)]
                .latestMsg =
            EncryptData.decryptAES(wholeJson.msgData!.message!, senderIdObj.id);

        emit(LoadedState(users: dummyList));
        return;
      } else if (Prefs.getString(Prefs.myUserId) == senderIdObj.id) {
        dummyList[dummyList
                    .indexWhere((element) => element.sId == receiverIdObj.id)]
                .latestMsg =
            EncryptData.decryptAES(wholeJson.msgData!.message!, senderIdObj.id);

        emit(LoadedState(users: dummyList));
        return;
      }
    }
  }

  void typing(Object args, bool isTyping) {
    Map<dynamic, dynamic> socketData = jsonDecode(jsonEncode(args));
    var wholeJson = SocketTyping.fromJson(socketData);
    if (wholeJson.selectFrienddata == Prefs.getString(Prefs.myUserId)) {
      for (var i = 0; i < dummyList.length; i++) {
        if (dummyList[i].sId == wholeJson.userId) {
          if (isTyping) {
            dummyList[dummyList
                    .indexWhere((element) => element.sId == wholeJson.userId)]
                .latestMsg = StringsEn.typing;
          } else {
            dummyList[dummyList
                    .indexWhere((element) => element.sId == wholeJson.userId)]
                .latestMsg = wholeJson.lastmsg!;
          }
          emit(LoadedState(users: dummyList));
          return;
        }
      }
    }
  }

  void changeOnlineStatus(Object args) {
    Map<dynamic, dynamic> socketData = jsonDecode(jsonEncode(args));
    var onlineStatusObj = SocketOnlineStatus.fromJson(socketData);
    for (var i = 0; i < dummyList.length; i++) {
      if (dummyList[i].sId == onlineStatusObj.userId) {
        dummyList[dummyList
                .indexWhere((element) => element.sId == onlineStatusObj.userId)]
            .onlineStatus = onlineStatusObj.status;
        emit(LoadedState(users: dummyList));
        return;
      }
    }
  }
}
