import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/socket_helper.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';

import '../../../../injections.dart';
import '../../../resources/shared_preference.dart';
import '../socket/users_socket_utils.dart';
import 'helper_models.dart';

class NotificationHelper {



  static initAwesome() async {
    if (!kIsWeb) {
      AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
          null,
          [
            NotificationChannel(
                channelGroupKey: 'basic_channel_group',
                channelKey: 'android_channel_id',
                channelName: 'Basic notifications',
                channelDescription: 'Notification channel for basic tests',
                defaultColor: RingyColors.primaryColor,
                channelShowBadge: true,
                importance: NotificationImportance.Max,
                ledColor: Colors.white)
          ],
          // Channel groups are only visual and are not required
          channelGroups: [
            NotificationChannelGroup(
                channelGroupKey: 'basic_channel_group',
                channelGroupName: 'Basic group')
          ],
          debug: true
      );

      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });


      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );


    }
  }





  static createNotificationAwesome(RemoteMessage message) {
    Map<String,String> mData = returnMapData(message.data);
    // RemoteNotification? notification = message.notification;
    // AndroidNotification? android = message.notification?.android;
    if (!kIsWeb) {
      showNotificationAwesome(mData['status'] == StringsEn.callNotification,mData);

    }
  }

 static void showNotificationAwesome(bool callNotification, Map<String,String> mData){
    if (callNotification) {
      final _socketProvider = serviceLocator<SocketProviderUsers>();
      _socketProvider.getSocket();
      _socketProvider.mSocketEmit(
          SocketHelper.emitCallAccepted,
          HelperModels.getCallStatusForSocket(
              Prefs.getString(Prefs.myUserId)!, "2", true, false));
      AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: int.parse(StringsEn.callNotificationId),
                channelKey: 'android_channel_id',
                title: mData['title'],
                body: mData['body'],
                category: NotificationCategory.Call,
                payload: mData,
                autoDismissible: false,
              ),
              actionButtons: [
                NotificationActionButton(
                  key: 'accept',
                  label: 'accept',
                  icon: "resource://drawable/launch_background",
                  showInCompactView: true,
                  autoDismissible: false,
                ),
                NotificationActionButton(
                  key: 'reject',
                  label: 'reject',
                  icon: "resource://drawable/launch_background",
                  showInCompactView: true,
                  autoDismissible: false,
                ),
              ]
          );
    } else {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: int.parse(StringsEn.simpleMessageNotificationId),
            channelKey: 'android_channel_id',
            title: mData['title'],
            category: NotificationCategory.Message,
            body: mData['body'],
            autoDismissible: false,
          ),
      );
    }
  }

  static Map<String, String> returnMapData(Map<String, dynamic> data) {
    Map<String, String> returnMap = {};
    for (var element in data.entries) {
      returnMap[element.key] = element.value.toString();
    }
    return returnMap;
  }

}

