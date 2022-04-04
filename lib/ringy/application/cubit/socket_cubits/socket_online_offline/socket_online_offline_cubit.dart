import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/socket_helper.dart';
import 'package:flutter_chat/ringy/presentation/core/socket/socket_utils.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as sio;
part 'socket_online_offline_state.dart';

class SocketOnlineOfflineCubit extends Cubit<SocketOnlineOfflineInitial>{
  int onlineValue;
  late sio.Socket _socketProvider;
  SocketOnlineOfflineCubit(this.onlineValue) : super(SocketOnlineOfflineInitial(onlineValue: onlineValue));


  void changeOnline(int value)  {
  emit(SocketOnlineOfflineInitial(onlineValue: value));
  }

   initSocket() {
    // _socketProvider.setEventListener(this);
    // _socketProvider.getSocket();
    _socketProvider = sio.io(
      Constants.SOCKET_URL,
      sio.OptionBuilder()
          .setTransports(['websocket'])
          .setTimeout(3000)
          .disableAutoConnect()
          .disableReconnection()
          .build(),
    );
    _socketProvider.connect();

    mSocketOn(SocketHelper.changeLogoutStatus);
    mSocketOn(SocketHelper.changeLoginStatus);
  }

  void mSocketOn(String eventName) {
    _socketProvider.on(eventName, (data) => {
      eventListener(eventName, data)
    });
  }

  void eventListener(String eventName, Object args) {
    if(eventName == SocketHelper.changeLogoutStatus){
      changeOnline(0);
    }else if(eventName == SocketHelper.changeLoginStatus){
      changeOnline(1);
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    // _socketProvider.dispose();
    return super.close();
  }
}


