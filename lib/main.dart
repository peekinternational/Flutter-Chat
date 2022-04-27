import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/domain/entities/socket_models/socket_online_status.dart';
import 'package:flutter_chat/ringy/infrastructure/data_sources/api_data_source.dart';
import 'package:flutter_chat/ringy/presentation/core/socket/users_socket_utils.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/socket_helper.dart';
import 'package:flutter_chat/ringy/presentation/routes/router.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import './injections.dart' as di;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  // GestureBinding.instance.resamplingEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global =  MyHttpOverrides();
  await di.init();
  await Prefs.init();



  // Set the background messaging handler early on, as a named top-level function
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications',
      description: 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }



  runApp(MyApp());
}


class MyApp extends StatefulWidget with WidgetsBindingObserver {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _router = AppRouter();
  final _socketProvider = SocketProviderUsers();
  ApiDataSource apiDataSource = ApiDataSource();
  late String? _token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _socketProvider.getSocket();



    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print("GET INITIAL MESSAGE!");
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        print(channel.description);
        _token  = await FirebaseMessaging.instance.getToken();
        print(" TOKENNNNNNNNNNK :$_token");
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
             channelDescription:  channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ringy',
      debugShowCheckedModeBanner: false,
      theme: _baseTheme,
      routerDelegate: _router.delegate(),
      routeInformationParser: _router.defaultRouteParser(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        if (Prefs.getString(Prefs.myUserId) != null) {
          _socketProvider.mSocketEmit(SocketHelper.emitOnlineStatus,
              SocketOnlineStatus(Prefs.getString(Prefs.myUserId), 1));
          apiDataSource.userOnlineStatus(Prefs.getString(Prefs.myUserId), 1);
        }
        break;
      case AppLifecycleState.inactive:
        if (Prefs.getString(Prefs.myUserId) != null) {
          _socketProvider.mSocketEmit(SocketHelper.emitOnlineStatus,
              SocketOnlineStatus(Prefs.getString(Prefs.myUserId), 0));
          apiDataSource.userOnlineStatus(Prefs.getString(Prefs.myUserId), 0);
        }
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        if (Prefs.getString(Prefs.myUserId) != null) {
          apiDataSource.userOnlineStatus(Prefs.getString(Prefs.myUserId), 0);
        }
        break;
    }
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
