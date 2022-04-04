import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/data_travel_model.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/o2o/chat/chat.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/o2o/o2o_users/widgets/o2o_users.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/openFile/open_media_page.dart';
import 'package:flutter_chat/ringy/presentation/home/home_page.dart';
import 'package:flutter_chat/ringy/presentation/home/authentications/login_page.dart';
import 'package:flutter_chat/ringy/presentation/home/authentications/sign_up.dart';
import 'package:flutter_chat/ringy/presentation/home/authentications/sign_in_options.dart';
import 'package:flutter_chat/ringy/presentation/splash/splash.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignInOptionsPage),
    AutoRoute(page: O2OUsersPage),
    AutoRoute(page: LoginPage),
    AutoRoute(page: HomePage),
    AutoRoute(page: RegistrationPage),
    AutoRoute(page: ChatScreenPage),
    AutoRoute(page: OpenMediaPage),

  ],
)
class AppRouter extends _$AppRouter{
}