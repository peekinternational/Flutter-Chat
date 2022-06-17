class SocketHelper {
  static String singleSendMessage = "sendmsg";
  static String singleMessageReceived = "receivemsg";

  static String emitGroupMessage = "sendgroupmsg";
  static String onGroupMessageReceived = "receivegroupmsg";


  static String emitStartMsgTyping = "msgtyping";
  static String onStartMsgTyping = "starttyping";
  static String emitStopMsgTyping = "stopTyping";
  static String onStopMsgTyping = "stoptyping";
  static String emitOnlineStatus = "changeStatus";
  static String onOnlineStatus = "receivechangeStatus";
  static String emitUpdateChat = "updatechatmsg";
  static String onUpdateChat = "receiveupdatechatmsg";
  static String emitDeleteMessage = "senderdeletemsg";
  static String onDeleteMessage = "reciverdeletemsg";

  static String singleReceivedDeleteMessage = "reciverdeletemsg";
  static String singleReceivedMessageId = "receiveid";

  static String groupSendMessage = "sendgroupmsg";
  static String groupReceivedId = "groupreceiveid";

  static String emitCallAccepted = "callAccepted";
  static String onCallAccepted = "_callAccepted";


  // socket.on('leaveAndroidUser', function (data) {
  //   io.emit('_leaveAndroidUser', data);
  // });


  static String GROUP_RECEIVED_DEL_MSG = "grpreciverdeletemsg";
  static String GROUP_RECEIVED_MSG = "receivegroupmsg";
  static String ISRINGING = "_isRinging";
  static String _ISRINGING = "isRinging";
  static String ROOM_LEAVE_SEND_AndroidUser = "leaveAndroidUser";
  static String ROOM_LEAVE_RECIEVED_AndroidUser = "_leaveAndroidUser";
  static String LEAVE_ROOM_CALL_Socket = "leaveRoomCall";

  static String ReceiveUpdateCallStatus = "receiveupdateCallStatus";
  static String ReceiveGroupDetail = "receiveGroupdetail";
  static String O2OReceiveStarTimer = "O2OreceivestarTimer";

  static String START_TYPE_MSG = "starttyping";
  static String STOP_TYPE_MSG = "stoptyping";
  static String _STOP_TYPE_MSG = "stopTyping";

  static String TYPING_MSG = "msgtyping";

  static String USER_RECEIVED_STATUS = "receiverUserStatus";
  static String changeLogoutStatus = "changestatuslogout";
  static String changeLoginStatus = "changestatuslogin";
  static String READ_RECEIPT = "receiveUpdateReadReceipt";
  static String UPDATE_READ_RECEIPT = "updateReadReceipt";

  static const String LOGIN = "login";
  static const String Join_All_Rooms = "join_all_rooms";
  static const String LOGOUT = "logout";
  static const String HIDE_ONLINE_STATUS_EMIT = "ringyHideOnlineStatus";
  static const String HIDE_ONLINE_STATUS_GET = "_ringyHideOnlineStatus";

  // Socket for emit
  static String UPDATE_CHAT_MSG_EDIT = "updatechatmsg";

  //socket for on
  static String RECEIVED_UPDATE_CHAT_MSG = "receiveupdatechatmsg";

  // Call Accept

  static String CALL_ACCEPT = "callAccepted";
  static String _CALL_ACCEPT = "_callAccepted";

  static String updateUserSelection = "updateUserSelection";
  static String groupSendId = "groupsendid";
  static String sendId = "sendid";
  static String receiveMsg = "receivemsg";

  static String receiverUserStatus = "receiverUserStatus";
  static String receiveUpdateReadReceipt = "receiveUpdateReadReceipt";
  static String grpSenderDeleteMsg = "grpsenderdeletemsg";
  static String senderDeleteMsg = "senderdeletemsg";
}
