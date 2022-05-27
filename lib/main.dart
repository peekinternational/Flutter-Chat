import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/domain/entities/socket_models/socket_online_status.dart';
import 'package:flutter_chat/ringy/infrastructure/data_sources/api_data_source.dart';
import 'package:flutter_chat/ringy/presentation/core/socket/users_socket_utils.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/notification_helper.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/socket_helper.dart';
import 'package:flutter_chat/ringy/presentation/routes/router.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';

import './injections.dart' as di;


Future<void> main() async {
  // GestureBinding.instance.resamplingEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global =  MyHttpOverrides();
  await di.init();
  await Prefs.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(NotificationHelper.firebaseMessagingBackgroundHandler);
  await NotificationHelper.init();
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _socketProvider.getSocket();
    changeOnlineStatus(1);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      NotificationHelper.showNotification(message);
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
        changeOnlineStatus(1);
        break;
      case AppLifecycleState.inactive:
        changeOnlineStatus(0);
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

  void changeOnlineStatus(int value){
    if (Prefs.getString(Prefs.myUserId) != null) {
      _socketProvider.mSocketEmit(SocketHelper.emitOnlineStatus,
          SocketOnlineStatus(Prefs.getString(Prefs.myUserId), value));
      apiDataSource.userOnlineStatus(Prefs.getString(Prefs.myUserId), value);
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
