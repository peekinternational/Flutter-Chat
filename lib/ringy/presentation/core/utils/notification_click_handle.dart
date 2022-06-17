import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_chat/injections.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/socket_helper.dart';
import 'package:flutter_chat/ringy/presentation/routes/router.dart';

import '../../../resources/shared_preference.dart';
import '../../../resources/strings_en.dart';
import '../socket/users_socket_utils.dart';
import 'helper_models.dart';

class NotificationClickHandle {
  bool alreadyListening = false;
  final _socketProvider = SocketProviderUsers();

  void listenToNotification() {
    if (!alreadyListening) {
      // AwesomeNotifications().actionStream.listen((action) {
      //   _socketProvider.getSocket();
      //   alreadyListening = true;
      //   AwesomeNotifications().dismiss(action.id!);
      //   if (action.buttonKeyPressed == "accept") {
      //     serviceLocator<AppRouter>().push(CallIncomingRoute(
      //         senderName: "senderName", senderId: "senderId", senderImage: ""));
      //   } else if (action.buttonKeyPressed == "reject") {
      //     _socketProvider.mSocketEmit(
      //         SocketHelper.emitCallAccepted,
      //         HelperModels.getCallStatusForSocket(
      //             Prefs.getString(Prefs.myUserId)!, "0", true, false));
      //   } else if (action.id == int.parse(StringsEn.callNotificationId)) {
      //     serviceLocator<AppRouter>().push(CallIncomingRoute(
      //         senderName: "senderName", senderId: "senderId", senderImage: ""));
      //   } else if (action.id ==
      //           int.parse(StringsEn.simpleMessageNotificationId) &&
      //       !serviceLocator<AppRouter>().isPathActive("/home-page")) {
      //     print(
      //         "objectSSSSSSSSSSSSSSSSS: ${serviceLocator<AppRouter>().isPathActive("/home-page")}");
      //     serviceLocator<AppRouter>().push(HomeRoute(currentIndex: 0));
      //   } else {}
      // });
    }
  }

  void dismissListening() {
    alreadyListening = false;
    // AwesomeNotifications().actionSink.close();
  }
}
