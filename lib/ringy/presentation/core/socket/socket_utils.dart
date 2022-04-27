import 'package:flutter/cupertino.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as sio;

abstract class SocketEvents {
  void eventListener(String eventName, Object args);
}

class SocketProvider {


  static final SocketProvider socketProvider = SocketProvider._();

  SocketProvider._();

  static SocketProvider get instance => socketProvider;
  late sio.Socket socket;
  late SocketEvents mEventListener;

  void setEventListener(SocketEvents eventListener) {
    mEventListener = eventListener;
  }



  getSocket() {
    socket = sio.io(
      Constants.socketURL,
      sio.OptionBuilder()
          .setTransports(['websocket'])
          .setTimeout(3000)
          .disableAutoConnect()
          .disableReconnection()
          .build(),
    );
    if (!socket.connected) {
      socket.connect();
    }
  }

  void socketConnect() {
    if (!socket.connected) {
      socket.connect();
    }
  }

  void socketDisconnect() {
    // socket.disconnect();
    // socket.dispose();
    // socket.close();
  }

  void mSocketOn(String eventName) {
    // mSocketOff(eventName);
    socket.on(
        eventName, (data) => {mEventListener.eventListener(eventName, data)});
  }

  void mSocketEmit(String eventName, Object object) {
    socket.emit(eventName, object);
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
