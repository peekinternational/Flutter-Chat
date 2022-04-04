import 'package:flutter/material.dart';
import 'package:flutter_chat/ringy/presentation/home/authentications/widgets/buttons_form_widget.dart';
import 'package:flutter_chat/ringy/presentation/routes/router.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';
import 'package:flutter_chat/ringy/resources/styles.dart';
import 'package:auto_route/auto_route.dart';

class SignInOptionsPage extends StatelessWidget {
  const SignInOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }
}

_buildBody(BuildContext context) {
  return Container(
    color: RingyColors.lightWhite,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildButtons(Icons.login, StringsEn.signIn, context),
          const SizedBox(
            height: 15,
          ),
          _buildButtons(
              Icons.attach_email_outlined, StringsEn.register, context),
        ],
      ),
    ),
  );
}

_buildButtons(IconData iconData, String authOptions, BuildContext context) {
  return ButtonsFormWidgets(
    delay: authOptions == StringsEn.signIn ? 600 : 800,
    iconData: iconData,
    textString: authOptions,
    onTap: () {
      _nextPage(context, authOptions);
    },
  );
}

void _nextPage(BuildContext context, String page) {
  page == StringsEn.signIn
      ? context.pushRoute(LoginRoute())
      : context.pushRoute(RegistrationRoute());
}
