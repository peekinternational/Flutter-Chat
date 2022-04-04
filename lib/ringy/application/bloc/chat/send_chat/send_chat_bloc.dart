import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chal_file_share.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/send_message_api.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/update_chat_api.dart';
import 'package:flutter_chat/ringy/infrastructure/_repository.dart';



part 'send_chat_event.dart';
part 'send_chat_state.dart';

class SendChatBloc extends Bloc<SendChatEvent, SendChatState> {
  final Repository repository;

  SendChatBloc(this.repository) : super(SendChatInitial()) {
    on<SendChatsEvent>(_onEventSendMessage, transformer: sequential());
    on<ShareFileEvent>(_onEventShareChat, transformer: sequential());
    on<UpdateMessageEvent>(_onEventUpdateChat, transformer: sequential());
  }


  FutureOr<void> _onEventSendMessage(SendChatsEvent event,
      Emitter<SendChatState> emit) async {
    emit(LoadingState());
    var result = await repository.sendMessage(event.model);
    emit(result.fold((l) => ErrorState(), (r) =>
        LoadedState(chats: r)));
  }
  FutureOr<void> _onEventShareChat(ShareFileEvent event,
      Emitter<SendChatState> emit) async {
    emit(LoadingState());
    var result = await repository.chatFileShare(event.model);
    emit(result.fold((l) => ErrorState(), (r) =>
        LoadedShareChatState(chats: r)));
  }
  FutureOr<void> _onEventUpdateChat(UpdateMessageEvent event,
      Emitter<SendChatState> emit) async {
    emit(LoadingState());
    var result = await repository.updateMessage(event.model);
    emit(result.fold((l) => ErrorState(), (r) =>
        LoadedUpdateChatState(chats: r)));
  }
}


