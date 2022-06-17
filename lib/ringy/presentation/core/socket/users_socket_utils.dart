


import 'package:flutter/cupertino.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as sio;
abstract class SocketEventsUsers {
  void eventListener(String eventName, Object args);
}

abstract class SocketEventsGroups {
  void eventListener(String eventName, Object args);
}

abstract class SocketEventsChat {
  void eventListener(String eventName, Object args);
}
abstract class SocketEventsCall {
  void eventListener(String eventName, Object args);
}


class SocketProviderUsers {
  static final SocketProviderUsers _singleton = SocketProviderUsers._internal();

  // static final SocketProviderUsers socketProvider = SocketProviderUsers._();
  // SocketProviderUsers._();
  // static SocketProviderUsers get instance => socketProvider;
  late sio.Socket socket;
  SocketProviderUsers._internal();
  SocketEventsUsers? mEventListener;
  SocketEventsGroups? mEventListenerGroups;
  SocketEventsChat? mEventListenerChat;
  SocketEventsCall? mEventListenerCall;

  factory SocketProviderUsers() {
    return _singleton;
  }



   void setEventListener(SocketEventsUsers eventListener) {
    mEventListener = eventListener;
  }
  void setEventListenerGroups(SocketEventsGroups eventListener) {
    mEventListenerGroups = eventListener;
  }
  void setEventListenerChat(SocketEventsChat eventListener) {
    mEventListenerChat = eventListener;
  }
  void setEventListenerCall(SocketEventsCall eventListener) {
    mEventListenerCall = eventListener;
  }




   getSocket()  {
    socket = sio.io(
      Constants.socketURL,
      sio.OptionBuilder()
          .setTransports(['websocket'])
          .setTimeout(3000)
          .disableAutoConnect()
          .disableReconnection()
          .build(),
    );
    socket.connect();
  }

   void socketConnect() {

    socket.connect();
  }

   void socketDisconnect() {
    socket.disconnect();
    socket.dispose();
    socket.close();
  }

  void mSocketOn(String eventName) {
    mSocketOff(eventName);
    socket.on(eventName, (data) => {
      print("objectFromUTILS : $eventName"),
      mEventListener?.eventListener(eventName, data),
      mEventListenerChat?.eventListener(eventName, data),
      mEventListenerGroups?.eventListener(eventName, data),
      mEventListenerCall?.eventListener(eventName, data),
    });
  }

   void mSocketEmit(String eventName, Object object) {
    socket.emit(eventName,object);
  }

   void mSocketOff(String eventName) {
    socket.off(eventName);
  }


   bool isCheckConnected() {
    if (socket.connected) {
      return true;
    } else {
      return false;
    }

  }

}