import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/socket_models/socket_online_status.dart';
import 'package:flutter_chat/ringy/infrastructure/data_sources/api_data_source.dart';
import 'package:flutter_chat/ringy/presentation/core/socket/users_socket_utils.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/socket_helper.dart';
import 'package:flutter_chat/ringy/presentation/routes/router.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';

import './injections.dart' as di;

Future<void> main() async {
  GestureBinding.instance?.resamplingEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global =  MyHttpOverrides();
  await di.init();
  await Prefs.init();
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
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _socketProvider.getSocket();
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
