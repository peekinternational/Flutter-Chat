
 class APIContent {
   static String mainURL="https://peekvideochat.com:22000/";
   static String GetO2O_Users = "getUsers";
   static String O2O_CHAT_FETCH = "getChat";
   static String CHAT_SEND_URL = "chat";
   static String UPDATE_MESSAGE_URL = "updateChat";
   static String DELETE_MESSAGE_URL = "deleteMsg";
   static String CHAT_FILE_SHARE_URL = "chatFilesShare";
   static String ImageUrl = mainURL+"images/chatImages/";









   static const String FCM_URL = "https://fcm.googleapis.com/";
   static String Call_Server_URL="https://stun.ringy.jp/";
   static String MainUrl="https://ringy.jp:22000/";

   static const String SERVER_KEY = "AAAAZPF--2E:APA91bEIk6CmPndcYp9NzEB5pXGh_7Vrke11UJIuL85mdJEEr_9ZgsT3PMKhZRfaOq75Nxc_nAGAJX5rd32OC5nWxfv2vXkpin4RUwuO81CdBZsnV1yOMT_oLCIe89N3dJM2CRUsq09I";

   static String WallPaperURL = MainUrl+"backgrounds/bg_pack0/";
  //  https://ringy.jp:22000//backgrounds/bg_pack0/
   static String ImageUrl1 = MainUrl+"images/";

  //    static String SOCKET_URL = "https://turn.chatto.jp:21000";//only for testing
   static String SOCKET_URL = "https://ringy.jp:22000";
   static String PROJECT_ID = "5d4c07fb030f5d0600bf5c03";
  //  static String MainUrlOrignal="https://ringy.jp:22000/";
  //  https://turn.chatto.jp:21000/getAllIds/6119fbb1fa0daefc6f957133/5d4c07fb030f5d0600bf5c03
   static String deviceType = "android";
   static String UserRegister = "UserRegister";
   static String Login = "RingyLogin";
   static String CheckMobile = "CheckMobile";
   static String UpdateFCM = "UpdateFCM";
   static String IsEmailVerifyed = "IsEmailVerified";
   static String VerifyEmail = "VerifyEmail";
   static String IsEmailReSend = "resendEmail";
   static String DeleteUser = "DeleteUser";
   static String ClearCallHistory = "RingyRemoveCallHistory";

   static String Logout = "RingyLogout";


   static String ForgotPassword = "forgotPassword";
   static String ResetPassword = "ResetPassword";
   static String UpdateProfile = "UpdateProfile";
   static String SearchFriend = "SearchFriend";

   static String GetGroupDetail = "getGroupDetail";
   static String SearchPublicGroup = "RingySearchPublicGroup";
   static String ScanQrCode = "ScanQrCode";

   static String SentAccountRequest = "sentAccountRequest";
   static String AcceptAccountRequest = "acceptAccountRequest";

   static String DeleteRequest = "DeleteRequest";
   static String ReceiveRequestList = "ReceiveRequestList";
   static String SentRequestList = "SentRequestList";
   static String AcceptRequest = "AcceptRequest";
   static String FriendList = "FriendList";
   static String RingyGetChatMedia = "RingyGetChatMedia";
   static String GetAllBackgrounds = "getAllBackgrounds";
   static String RingyGetChatFile = "RingyGetChatFile";
   static String AllFriendList = "getAllFriends";
   static String DisableUser = "DisableUser";
   static String ChangePassword = "ChangePassword";
   static String UpdateMobile = "UpdateMobile";

   static String BlockList = "BlockFriendList";
   static String MuteList = "MuteFriendList";
   static String HideList = "HideFriendList";

   static String LatestNotes = "LatestNotes";
   static String LatestNotification = "NotificationList";
   static String FriendProfile = "FriendProfile";
   static String Mute = "MuteFriend";
   static String Hide = "HideFriend";
   static String Block = "BlockFriend";
   static String AppVersion = "checkAppVersion";

   static String getHome = "getHome";
   static String TypeList = "Feedback/TypeList";
   static String Add = "Feedback/Add";
   static String UpdateRing = "UpdateRing";

   static String GetGroupMember = "GetGroupMembers";
   static String RingyJoinGroup = "RingyJoinGroup";


   static String GetUserRing = "GetUserRing";
   static String CreateRing = "CreateRing";
   static String SetDefaultRing = "SetDefaultRing";
   static String ChangeFriendRing = "ChangeFriendRing";
   static String ChangeEmail = "ChangeEmail";
   static String MuteRing = "MuteRing";
   static String MuteGroup = "RingyMuteGroup";
   static String HideRing = "HideRing";
   static String HideRingList = "HideRingList";
   static String MuteRingList = "MuteRingList";
   static String BlockRingList = "LockedRingList";
   static String DeleteRing = "DeleteRing";
   static String DeleteNotification = "DeleteNotification";
   static String ReadNotification = "ReadNotification";
   static String AllCounts = "AllCounts";
   static String ChangeRingQr = "ChangeRingQr";
   static String HideRingid = "HideIdRing";
   static String BlockRing = "LockRing";
   static String HideRingidList = "HideRingidList";//param u_id   note:Hide ID na List ni api chhe  //@chirag



   static String GET_GROUP_CHAT = "GetRingyGroupChat";
   static String GET_BOOKMARK_CHAT = "GetBookmarkChats";
   static String GET_GROUPS = "GetRingyGroups";
   static String RINGY_READ_ALL_CHAT ="RingyReadAllChat";
   static String RINGY_UNREAD_ALL_CHAT = "RingyUnreadAllChat";
   static String RINGY_DELETE_ALL_CHAT = "RingyDeleteAllChat";
   static String HIDE_CHAT = "RingyChatHide";
   static String RINGY_CLEAR_ALL_CHAT = "RingyClearAllChats";
   static String RingyDeleteGroupUser = "RingyDeleteGroupUser";
   static String GET_HIDDEN_USERS_CHAT = "GetHiddenChatUsers";


   static String GROUP_CHAT_SEND_URL = "RingyGroupChat";
   static const String CHAT_UPDATE_URL = "RingyUpdateChat";
   static const String RingyBookmarkChat = "RingyBookmarkChat";
   static String DELETE_MSG_FOR_EVERYONE = "RingDeleteMsg";
   static String DELETE_MY_CHAT = "RingDeleteMyMsg";
   static String EMPTY_CHAT_WITH_ID = "RingyEmptyChatWithId";
   static String RingyPinFriend = "RingyPinFriend";
   static String RingyPinGroup = "RingyPinGroup";




   static const String USER_TYPE ="0";
   static const String Authorization ="Authorization";
   static const String mobile ="phone";
   static const String password ="password";
   static const String email ="email";
   static const String projectId ="projectId";
   static const String fcm_id ="fcm_id";
   static const String u_id ="userId";
   static const String name ="name";
   static const String birth ="dob";
   static const String f_u_id ="f_u_id";
   static const String qr_code ="qr_code";
   static const String req_id ="req_id";
   static const String active ="active";
   static const String cnguserid ="cnguserid";
   static const String user_name ="user_name";

   static const String new_mobile ="new_mobile";
   static const String gender ="gender";
   static const String login_id ="login_id";
   static const String mute ="mute";
   static const String hide ="hide";
   static const String block ="block";
   static const String type_id ="type_id";
   static const String feedback ="feedback";
   static const String lang ="lang";
   static const String ring_name ="ring_name";
   static const String ring_user_id ="ring_user_id";
   static const String ring_id ="ringId";
   static const String userId ="userId";
   static const String onlineStatus ="onlineStatus";
   static const String user_id ="user_id";
   static const String new_ring_id ="new_ring_id";
   static const String u_ring_id  ="u_ring_id";
   static const String f_u_ring_id   ="f_u_ring_id";
   static const String old_email ="old_email";

   static const String act ="act";

   static String registered_successfully = "1";
   static String already_registered = "0";

   static const String code = "code";
   static  const String p_image ="p_image";

   static const String profilePhoto = "profilePhoto";

   static const String userImage = "userImage";
   static const String user_image = "user_image";
   static const String old_password = "oldPassword";
   static const String new_password = "newPassword";
   static const String disableStatus = "disableStatus";
   static const String new_email ="newEmail";
   static const String GetAllRingyIds ="getAllRingyIds";


   static const String user_ring_id= "user_ring_id";
   static const String groupId="groupId";
   static String FILE_URL = "RingChatFilesShare";

   // new vars

   static const String registerUser = "projects/register-user";
   static const String loginUser = "business/login";
   static const String userOnlineStatus = "setOnlineStatus";








}
