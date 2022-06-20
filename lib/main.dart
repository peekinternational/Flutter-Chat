import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/domain/entities/socket_models/socket_online_status.dart';
import 'package:flutter_chat/ringy/infrastructure/data_sources/api_data_source.dart';
import 'package:flutter_chat/ringy/presentation/core/socket/users_socket_utils.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/helper_models.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/notification_click_handle.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/notification_controller.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/notification_helper.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/socket_helper.dart';
import 'package:flutter_chat/ringy/presentation/home/call/call_out.dart';
import 'package:flutter_chat/ringy/presentation/home/call/join_screen.dart';
import 'package:flutter_chat/ringy/presentation/routes/router.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';

import './injections.dart' as di;
import 'injections.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  await di.init();
  await Prefs.init();
  await NotificationHelper.initAwesome();
  NotificationHelper.createNotificationAwesome(message);
  AwesomeNotifications().setListeners(
      onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod,
  );

}

Future<void> main() async {
  // GestureBinding.instance.resamplingEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await di.init();
  await Prefs.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await NotificationHelper.initAwesome();
  runApp(MyApp());
}

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _socketProvider = SocketProviderUsers();
  ApiDataSource apiDataSource = ApiDataSource();
  final router = serviceLocator<AppRouter>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _socketProvider.getSocket();
    changeOnlineStatus(1);
    setupNotification();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Chat',
      debugShowCheckedModeBanner: false,
      theme: _baseTheme,
      routerDelegate: AutoRouterDelegate(router),
      routeInformationParser: router.defaultRouteParser(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        changeOnlineStatus(1);
        break;
      case AppLifecycleState.inactive:
        changeOnlineStatus(0);
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        if (Prefs.getString(Prefs.myUserId) != null) {
          apiDataSource.userOnlineStatus(Prefs.getString(Prefs.myUserId), 0);
        }
        break;
    }
  }

  void changeOnlineStatus(int value) {
    if (Prefs.getString(Prefs.myUserId) != null) {
      _socketProvider.mSocketEmit(SocketHelper.emitOnlineStatus,
          SocketOnlineStatus(Prefs.getString(Prefs.myUserId), value));
      apiDataSource.userOnlineStatus(Prefs.getString(Prefs.myUserId), value);
    }
  }

  void setupNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if(message.data["title"] == "cancelAll"){
        AwesomeNotifications().dismissAllNotifications();
        return;
      }
      NotificationHelper.createNotificationAwesome(message);
    });

    AwesomeNotifications().setListeners(
        onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    );
  }
}

ThemeData _baseTheme = ThemeData(
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: RingyColors.overlay));

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
