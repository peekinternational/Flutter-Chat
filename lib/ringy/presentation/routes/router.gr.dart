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
      final args = routeData.argsAs<HomeRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: HomePage(args.currentIndex, key: args.key));
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
    },
    AddGroupUsersRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const AddGroupUsersPage());
    },
    AddGroupSubjectRoute.name: (routeData) {
      final args = routeData.argsAs<AddGroupSubjectRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: AddGroupSubjectPage(args.mListSelected, key: args.key));
    },
    SwitchFriendRoute.name: (routeData) {
      final args = routeData.argsAs<SwitchFriendRouteArgs>(
          orElse: () => const SwitchFriendRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: SwitchFriendPage(key: args.key));
    },
    CallIncomingRoute.name: (routeData) {
      final args = routeData.argsAs<CallIncomingRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: CallIncomingPage(
              args.senderName, args.senderId, args.senderImage,
              key: args.key));
    },
    CallOutRoute.name: (routeData) {
      final args = routeData.argsAs<CallOutRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: CallOutPage(args.receiverName, args.receiverId,
              args.receiverImage, args.fcmIdList, args.groupCall,
              key: args.key));
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
        RouteConfig(O2OUsersRoute.name, path: '/o2-ousers-page'),
        RouteConfig(ChatScreenRoute.name, path: '/chat-screen-page'),
        RouteConfig(OpenMediaRoute.name, path: '/open-media-page'),
        RouteConfig(AddGroupUsersRoute.name, path: '/add-group-users-page'),
        RouteConfig(AddGroupSubjectRoute.name, path: '/add-group-subject-page'),
        RouteConfig(SwitchFriendRoute.name, path: '/switch-friend-page'),
        RouteConfig(CallIncomingRoute.name, path: '/call-incoming-page'),
        RouteConfig(CallOutRoute.name, path: '/call-out-page')
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
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({required int currentIndex, Key? key})
      : super(HomeRoute.name,
            path: '/home-page',
            args: HomeRouteArgs(currentIndex: currentIndex, key: key));

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({required this.currentIndex, this.key});

  final int currentIndex;

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{currentIndex: $currentIndex, key: $key}';
  }
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

/// generated route for
/// [AddGroupUsersPage]
class AddGroupUsersRoute extends PageRouteInfo<void> {
  const AddGroupUsersRoute()
      : super(AddGroupUsersRoute.name, path: '/add-group-users-page');

  static const String name = 'AddGroupUsersRoute';
}

/// generated route for
/// [AddGroupSubjectPage]
class AddGroupSubjectRoute extends PageRouteInfo<AddGroupSubjectRouteArgs> {
  AddGroupSubjectRoute({required List<UsersList> mListSelected, Key? key})
      : super(AddGroupSubjectRoute.name,
            path: '/add-group-subject-page',
            args: AddGroupSubjectRouteArgs(
                mListSelected: mListSelected, key: key));

  static const String name = 'AddGroupSubjectRoute';
}

class AddGroupSubjectRouteArgs {
  const AddGroupSubjectRouteArgs({required this.mListSelected, this.key});

  final List<UsersList> mListSelected;

  final Key? key;

  @override
  String toString() {
    return 'AddGroupSubjectRouteArgs{mListSelected: $mListSelected, key: $key}';
  }
}

/// generated route for
/// [SwitchFriendPage]
class SwitchFriendRoute extends PageRouteInfo<SwitchFriendRouteArgs> {
  SwitchFriendRoute({Key? key})
      : super(SwitchFriendRoute.name,
            path: '/switch-friend-page', args: SwitchFriendRouteArgs(key: key));

  static const String name = 'SwitchFriendRoute';
}

class SwitchFriendRouteArgs {
  const SwitchFriendRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SwitchFriendRouteArgs{key: $key}';
  }
}

/// generated route for
/// [CallIncomingPage]
class CallIncomingRoute extends PageRouteInfo<CallIncomingRouteArgs> {
  CallIncomingRoute(
      {required String? senderName,
      required String? senderId,
      required String? senderImage,
      Key? key})
      : super(CallIncomingRoute.name,
            path: '/call-incoming-page',
            args: CallIncomingRouteArgs(
                senderName: senderName,
                senderId: senderId,
                senderImage: senderImage,
                key: key));

  static const String name = 'CallIncomingRoute';
}

class CallIncomingRouteArgs {
  const CallIncomingRouteArgs(
      {required this.senderName,
      required this.senderId,
      required this.senderImage,
      this.key});

  final String? senderName;

  final String? senderId;

  final String? senderImage;

  final Key? key;

  @override
  String toString() {
    return 'CallIncomingRouteArgs{senderName: $senderName, senderId: $senderId, senderImage: $senderImage, key: $key}';
  }
}

/// generated route for
/// [CallOutPage]
class CallOutRoute extends PageRouteInfo<CallOutRouteArgs> {
  CallOutRoute(
      {required String? receiverName,
      required String? receiverId,
      required String? receiverImage,
      required List<String?>? fcmIdList,
      required bool? groupCall,
      Key? key})
      : super(CallOutRoute.name,
            path: '/call-out-page',
            args: CallOutRouteArgs(
                receiverName: receiverName,
                receiverId: receiverId,
                receiverImage: receiverImage,
                fcmIdList: fcmIdList,
                groupCall: groupCall,
                key: key));

  static const String name = 'CallOutRoute';
}

class CallOutRouteArgs {
  const CallOutRouteArgs(
      {required this.receiverName,
      required this.receiverId,
      required this.receiverImage,
      required this.fcmIdList,
      required this.groupCall,
      this.key});

  final String? receiverName;

  final String? receiverId;

  final String? receiverImage;

  final List<String?>? fcmIdList;

  final bool? groupCall;

  final Key? key;

  @override
  String toString() {
    return 'CallOutRouteArgs{receiverName: $receiverName, receiverId: $receiverId, receiverImage: $receiverImage, fcmIdList: $fcmIdList, groupCall: $groupCall, key: $key}';
  }
}
