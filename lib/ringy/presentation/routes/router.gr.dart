// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const SplashPage());
    },
    SignInOptionsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const SignInOptionsPage());
    },
    O2OUsersRoute.name: (routeData) {
      final args = routeData.argsAs<O2OUsersRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: O2OUsersPage(args.showUsers, key: args.key));
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: LoginPage(key: args.key));
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const HomePage());
    },
    RegistrationRoute.name: (routeData) {
      final args = routeData.argsAs<RegistrationRouteArgs>(
          orElse: () => const RegistrationRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: RegistrationPage(key: args.key));
    },
    ChatScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ChatScreenRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: ChatScreenPage(args.dataTravel, key: args.key));
    },
    OpenMediaRoute.name: (routeData) {
      final args = routeData.argsAs<OpenMediaRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: OpenMediaPage(args.isVideo, args.url, key: args.key));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(SplashRoute.name, path: '/'),
        RouteConfig(SignInOptionsRoute.name, path: '/sign-in-options-page'),
        RouteConfig(O2OUsersRoute.name, path: '/o2-ousers-page'),
        RouteConfig(LoginRoute.name, path: '/login-page'),
        RouteConfig(HomeRoute.name, path: '/home-page'),
        RouteConfig(RegistrationRoute.name, path: '/registration-page'),
        RouteConfig(ChatScreenRoute.name, path: '/chat-screen-page'),
        RouteConfig(OpenMediaRoute.name, path: '/open-media-page')
      ];
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [SignInOptionsPage]
class SignInOptionsRoute extends PageRouteInfo<void> {
  const SignInOptionsRoute()
      : super(SignInOptionsRoute.name, path: '/sign-in-options-page');

  static const String name = 'SignInOptionsRoute';
}

/// generated route for
/// [O2OUsersPage]
class O2OUsersRoute extends PageRouteInfo<O2OUsersRouteArgs> {
  O2OUsersRoute({required bool showUsers, Key? key})
      : super(O2OUsersRoute.name,
            path: '/o2-ousers-page',
            args: O2OUsersRouteArgs(showUsers: showUsers, key: key));

  static const String name = 'O2OUsersRoute';
}

class O2OUsersRouteArgs {
  const O2OUsersRouteArgs({required this.showUsers, this.key});

  final bool showUsers;

  final Key? key;

  @override
  String toString() {
    return 'O2OUsersRouteArgs{showUsers: $showUsers, key: $key}';
  }
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({Key? key})
      : super(LoginRoute.name,
            path: '/login-page', args: LoginRouteArgs(key: key));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/home-page');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [RegistrationPage]
class RegistrationRoute extends PageRouteInfo<RegistrationRouteArgs> {
  RegistrationRoute({Key? key})
      : super(RegistrationRoute.name,
            path: '/registration-page', args: RegistrationRouteArgs(key: key));

  static const String name = 'RegistrationRoute';
}

class RegistrationRouteArgs {
  const RegistrationRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'RegistrationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ChatScreenPage]
class ChatScreenRoute extends PageRouteInfo<ChatScreenRouteArgs> {
  ChatScreenRoute({required TmpDataTravel dataTravel, Key? key})
      : super(ChatScreenRoute.name,
            path: '/chat-screen-page',
            args: ChatScreenRouteArgs(dataTravel: dataTravel, key: key));

  static const String name = 'ChatScreenRoute';
}

class ChatScreenRouteArgs {
  const ChatScreenRouteArgs({required this.dataTravel, this.key});

  final TmpDataTravel dataTravel;

  final Key? key;

  @override
  String toString() {
    return 'ChatScreenRouteArgs{dataTravel: $dataTravel, key: $key}';
  }
}

/// generated route for
/// [OpenMediaPage]
class OpenMediaRoute extends PageRouteInfo<OpenMediaRouteArgs> {
  OpenMediaRoute({required bool isVideo, required String url, Key? key})
      : super(OpenMediaRoute.name,
            path: '/open-media-page',
            args: OpenMediaRouteArgs(isVideo: isVideo, url: url, key: key));

  static const String name = 'OpenMediaRoute';
}

class OpenMediaRouteArgs {
  const OpenMediaRouteArgs(
      {required this.isVideo, required this.url, this.key});

  final bool isVideo;

  final String url;

  final Key? key;

  @override
  String toString() {
    return 'OpenMediaRouteArgs{isVideo: $isVideo, url: $url, key: $key}';
  }
}
