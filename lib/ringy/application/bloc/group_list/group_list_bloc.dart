import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_chat/ringy/domain/entities/chat/chat_message.dart';
import 'package:flutter_chat/ringy/domain/entities/socket_models/socket_receive_message.dart';
import 'package:flutter_chat/ringy/domain/entities/users/groupListModel/group_list_model.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';

import 'package:flutter_chat/ringy/infrastructure/_repository.dart';
import 'package:flutter_chat/ringy/presentation/core/socket/users_socket_utils.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/helper_class.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/message_enum.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/socket_helper.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/encryption_utils.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';


part 'group_list_event.dart';
part 'group_list_state.dart';


class GroupListBloc extends Bloc<GroupListEvent, GroupListState>
    implements SocketEventsGroups {
  final Repository repository;
  List<GroupList> dummyList = [];
  final _socketProvider = SocketProviderUsers();

  GroupListBloc(this.repository) : super(GroupListInitial()) {
    on<GetGroupsEvent>(_onEvent, transformer: sequential());
  }

  FutureOr<void> _onEvent(
      GetGroupsEvent event, Emitter<GroupListState> emit) async {
    emit(LoadingState());
    if (!event.showUsers) {
      _socketProvider.setEventListenerGroups(this);
      _socketProvider.getSocket();
      _socketProvider.mSocketOff(SocketHelper.onStartMsgTyping);
      _socketProvider.mSocketOff(SocketHelper.onStopMsgTyping);
      _socketProvider.mSocketOff(SocketHelper.singleMessageReceived);
      _socketProvider.mSocketOn(SocketHelper.onGroupMessageReceived);
      _socketProvider.mSocketOn(SocketHelper.onUpdateChat);
      _socketProvider.mSocketOn(SocketHelper.onDeleteMessage);
    }
    var result = await repository.getGroupsList(event.projectId, event.userId);
    result.fold((l) => emit(ErrorState()), (r) => checkUsersCount(r, emit));
  }

  checkUsersCount(List<GroupList> r, Emitter<GroupListState> emit) {
    dummyList = r;
    r.isNotEmpty ? emit(LoadedState(groups: r)) : emit(NoGroupsState());
  }

  @override
  void eventListener(String eventName, Object args) {
    if (eventName == SocketHelper.onGroupMessageReceived) {
      newMessageReceived(args);
    }
  }

  void newMessageReceived(Object args) {
    Map<dynamic, dynamic> socketData = jsonDecode(jsonEncode(args));
    var wholeJson = SocketReceiveMessage.fromJson(socketData);
    if(wholeJson.msgData!.isGroup == 0){
      return;
    }
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

        emit(LoadedState(groups: dummyList));
        return;
      } else if (Prefs.getString(Prefs.myUserId) == senderIdObj.id) {
        dummyList[dummyList
            .indexWhere((element) => element.sId == receiverIdObj.id)]
            .latestMsg =
            EncryptData.decryptAES(wholeJson.msgData!.message!, senderIdObj.id);

        emit(LoadedState(groups: dummyList));
        return;
      }
    }
  }


}

