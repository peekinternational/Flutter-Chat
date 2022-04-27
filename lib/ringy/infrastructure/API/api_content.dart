import '../../../app_config.dart';

class APIContent {
  static const String getO2oUsersURL = "getUsers";
  static const String getGroupsURL = "getCreatedGroups";
  static const String o2oChatFetchURL = "getChat";
  static const String groupChatFetchURL = "getGroupChat";
  static const String chatSendURL = "chat";
  static const String groupChatSendURL = "groupChat";
  static const String updateMessageURL = "updateChat";
  static const String deleteMessageURL = "deleteMsg";
  static const String chatFileShareURL = "chatFilesShare";
  static const String imageURl = AppConfig.mainURL + "images/chatImages/";
  static const String registerUserURL = "projects/register-user";
  static const String loginUserURL = "business/login";
  static const String userOnlineStatusURL = "setOnlineStatus";
  static const String getUserRing = "GetUserRing";
  static const String createGroup = "createUserGroup";
  static const String updateUserProfile = "updateUserProfile";


  static const String mobile = "phone";
  static const String password = "password";
  static const String email = "email";
  static const String projectId = "projectId";
  static const String name = "name";
  static const String userId = "userId";
  static const String onlineStatus = "onlineStatus";
  static const String fcmToken = "fcm_id";


}
