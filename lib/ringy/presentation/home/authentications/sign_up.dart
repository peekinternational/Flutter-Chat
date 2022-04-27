import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/ringy/application/cubit/auth/registration/registration_cubit.dart';
import 'package:flutter_chat/ringy/presentation/home/authentications/widgets/buttons_form_widget.dart';
import 'package:flutter_chat/ringy/presentation/home/authentications/widgets/text_form_filed_widget.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injections.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final RegistrationCubit registrationCubit =
        serviceLocator<RegistrationCubit>();
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: RingyColors.primaryColor,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: RingyColors.primaryColor,
        title: Text(
          StringsEn.register,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: RingyColors.lightWhite),
        ),
      ),
      body: BlocProvider<RegistrationCubit>(
        create: (context) => RegistrationCubit(registrationCubit.repository),
        child: SingleChildScrollView(child: _registrationForm(context)),
      ),
    );
  }

  _registrationForm(BuildContext context) {
    return Column(
      children: [
        TextFormFiledWidget(
            label: StringsEn.fullName,
            hint: StringsEn.fullName,
            onTextChanged: (ss) => {},
            controller: _nameController),
        TextFormFiledWidget(
            label: StringsEn.userId,
            hint: StringsEn.userId,
            onTextChanged: (ss) => {},
            controller: _userIdController),
        TextFormFiledWidget(
            delay: 300,
            label: StringsEn.phone,
            hint: StringsEn.phone,
            onTextChanged: (ss) => {},
            controller: _phoneController),
        TextFormFiledWidget(
            delay: 500,
            label: StringsEn.email,
            hint: StringsEn.email,
            onTextChanged: (ss) => {},
            controller: _emailController),
        TextFormFiledWidget(
            delay: 700,
            label: StringsEn.password,
            hint: StringsEn.password,
            onTextChanged: (ss) => {},
            controller: _passwordController),
        const SizedBox(height: 10),
        _buttonSubmit(context)
      ],
    );
  }

  Widget _buttonSubmit(BuildContext context) {
    return BlocConsumer<RegistrationCubit, RegistrationState>(
      listener: (context, state) {
        if (state is AlreadyRegisteredState) {
          VxToast.show(context, msg: StringsEn.alreadyRegistered);
        } else if (state is ErrorState) {
          VxToast.show(context, msg: state.error);
        } else if (state is SuccessState) {
          VxToast.show(context, msg: StringsEn.userSuccessfullyAdded);
          context.popRoute();
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: RingyColors.primaryColor,
            ),
          );
        }
        return ButtonsFormWidgets(
          delay: 700,
          iconData: Icons.attach_email_outlined,
          textString: StringsEn.submit,
          onTap: () => {
            if (_emailController.text.isNotEmpty &&
                _passwordController.text.isNotEmpty &&
                _passwordController.text.length >= Constants.passwordLength)
              BlocProvider.of<RegistrationCubit>(context).registerUser(
                  _emailController.text,
                  _phoneController.text,
                  _nameController.text,
                  _userIdController.text,
                  _passwordController.text)
            else
              VxToast.show(context, msg: StringsEn.enterEmailOrPassword)
          },
        );
      },
    );
  }
}
