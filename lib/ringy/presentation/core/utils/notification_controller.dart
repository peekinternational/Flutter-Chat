import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/socket_helper.dart';

import '../../../../injections.dart';
import '../../../resources/shared_preference.dart';
import '../../../resources/strings_en.dart';
import '../../routes/router.dart';
import '../socket/users_socket_utils.dart';
import 'helper_models.dart';

class NotificationController {
  static final _socketProvider = serviceLocator<SocketProviderUsers>();

  /// Use this method to detect when a new notification or a schedule is created
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
    if (receivedNotification.title == "cancelAll") {
      AwesomeNotifications().dismissAllNotifications();
    }
  }

  /// Use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
    _socketProvider.getSocket();
  }

  /// Use this method to detect if the user dismissed a notification
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    AwesomeNotifications().dismiss(receivedAction.id!);
    Map<String, String?>? mData = receivedAction.payload;

    if (receivedAction.buttonKeyPressed == "accept" &&
        !serviceLocator<AppRouter>().isPathActive("/call-incoming-page")) {
      serviceLocator<AppRouter>().push(CallIncomingRoute(
          senderName: mData!["fromName"],
          senderId: mData["fromId"],
          senderImage: mData["fromImage"]));
    } else if (receivedAction.buttonKeyPressed == "reject") {
      _socketProvider.mSocketEmit(
          SocketHelper.emitCallAccepted,
          HelperModels.getCallStatusForSocket(
              Prefs.getString(Prefs.myUserId)!, "0", true, false));
    } else if (receivedAction.id == int.parse(StringsEn.callNotificationId) &&
        !serviceLocator<AppRouter>().isPathActive("/call-incoming-page")) {
      serviceLocator<AppRouter>().push(CallIncomingRoute(
          senderName: mData!["fromName"],
          senderId: mData["fromId"],
          senderImage: mData["fromImage"]));
    } else if (receivedAction.id ==
            int.parse(StringsEn.simpleMessageNotificationId) &&
        !serviceLocator<AppRouter>().isPathActive("/home-page")) {
      print(
          "objectSSSSSSSSSSSSSSSSS: ${serviceLocator<AppRouter>().isPathActive("/home-page")}");
      serviceLocator<AppRouter>().push(HomeRoute(currentIndex: 0));
    } else {}
  }
}
