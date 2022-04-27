import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/ringy/application/cubit/auth/login/login_cubit.dart';
import 'package:flutter_chat/ringy/presentation/home/authentications/widgets/buttons_form_widget.dart';
import 'package:flutter_chat/ringy/presentation/home/authentications/widgets/text_form_filed_widget.dart';
import 'package:flutter_chat/ringy/presentation/routes/router.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../injections.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LoginCubit registrationCubit = serviceLocator<LoginCubit>();
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: RingyColors.primaryColor,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: RingyColors.primaryColor,
        title: Text(
          StringsEn.signIn,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: RingyColors.lightWhite),
        ),
      ),
      body: BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(registrationCubit.repository),
        child: SingleChildScrollView(child: _loginForm(context)),
      ),
    );
  }

  _loginForm(BuildContext context) {
    return Column(
      children: [
        TextFormFiledWidget(
            label: StringsEn.email,
            hint: StringsEn.email,
            onTextChanged: (ss) => {

            },
            controller: _emailController),
        TextFormFiledWidget(
            label: StringsEn.password,
            hint: StringsEn.password,
            onTextChanged: (ss) => {

            },
            controller: _passwordController),
        const SizedBox(height: 10),
        _buttonLoginButton(context)
      ],
    );
  }

  Widget _buttonLoginButton(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is InvalidUserState) {
          VxToast.show(context, msg: StringsEn.invalidEmailOrPassword);
        } else if (state is ErrorState) {
          VxToast.show(context, msg: state.error);
        } else if (state is SuccessState) {
          context.router.replaceAll([
            HomeRoute(currentIndex: 0)
          ]);
          // context.popRoute();
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return  Center(
            child: CircularProgressIndicator(
              color: RingyColors.primaryColor,
            ),
          );
        }
        return ButtonsFormWidgets(
          iconData: Icons.attach_email_outlined,
          textString: StringsEn.submit,
          onTap: () => {
          FocusScope.of(context).unfocus(),
            if (_emailController.text.isNotEmpty &&
                _passwordController.text.isNotEmpty &&
                _passwordController.text.length >= Constants.passwordLength)
              BlocProvider.of<LoginCubit>(context)
                  .loginUser(_emailController.text, _passwordController.text)
            else
              VxToast.show(context, msg: StringsEn.enterEmailOrPassword)
          },
        );
      },
    );
  }
}
