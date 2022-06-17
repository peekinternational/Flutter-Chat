import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_chat/ringy/presentation/routes/router.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';

import '../home/call/join_screen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
          () {
        Prefs.getString(Prefs.myUserId) == null
            ? {
          context.router.removeLast(),
          context.router.replace(const SignInOptionsRoute())
        } : {
          context.router.removeLast(),
          context.router.replace(HomeRoute(currentIndex: 0))
        };
      },
    );

    return const Picture();
  }
}

class Picture extends StatelessWidget {
  const Picture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        height: .35,
        width: double.infinity,
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 1800),
          tween: Tween<double>(begin: 2, end: 0.5),
          builder: (context, double value, child) =>
              Transform.scale(
                scale: value,
                child: SvgPicture.asset(
                  'assets/images/connect_friend_icon.svg',
                  color: Colors.green,
                ),
              ),
        ),
      ),
    );
  }
}
