import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/ringy/application/cubit/profile_settings/profile_settings_cubit.dart';
import 'package:flutter_chat/ringy/presentation/core/utils/helper_class.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/choose_file_image_with_percentage.dart';
import 'package:flutter_chat/ringy/presentation/home/authentications/widgets/buttons_form_widget.dart';
import 'package:flutter_chat/ringy/presentation/home/authentications/widgets/text_form_filed_widget.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../injections.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String iconPath = Prefs.getString(Prefs.myImage) ?? "";
  String name = Prefs.getString(Prefs.myName) ?? "";
  String email = Prefs.getString(Prefs.myMail) ?? "";
  bool changeForSave = false;
  bool fileIsSelectedFromGallery = Prefs.getString(Prefs.myImage) == "";

  @override
  Widget build(BuildContext context) {
    final ProfileSettingsCubit profileSettingsCubit =
        serviceLocator<ProfileSettingsCubit>();
    return Scaffold(
      body: BlocProvider<ProfileSettingsCubit>(
        create: (context) =>
            ProfileSettingsCubit(profileSettingsCubit.repository),
        child: _buildBody(context),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: RingyColors.lightWhite,
      ),
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      centerTitle: true,
      backgroundColor: RingyColors.lightWhite,
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [_buildIconBody(context), _buildTextsBody(context)],
      ),
    );
  }

  _buildIconBody(BuildContext context) {
    return Container(
      height: 200,
      color: RingyColors.lightWhite,
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: BlocConsumer<ProfileSettingsCubit, ProfileSettingsState>(
        listener: (context, state) {
          if (state is ChangeTextState) {
            changeForSave = state.changeForSave;
            iconPath = state.icon;
          } else if (state is ProfileSuccessState) {
            changeForSave = false;
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              changeForSave
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: state is ProfileLoadingState
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  right: 22.0, bottom: 8.0),
                              child: SizedBox(
                                width: 26,
                                height: 26,
                                child: CircularProgressIndicator(
                                  color: RingyColors.primaryColor,
                                ),
                              ),
                            )
                          : ButtonsFormWidgets(
                              iconData: Icons.check,
                              textString: StringsEn.save,
                              width: 80,
                              height: 40,
                              gapBetween: 4,
                              onTap: () => {
                                    FocusScope.of(context).unfocus(),
                                    BlocProvider.of<ProfileSettingsCubit>(
                                            context)
                                        .changeProfile(name, iconPath, email)
                                  }),
                    )
                  : const SizedBox(),
              Center(
                  child: InkWell(
                onTap: () => _getFromGallery(context),
                child: ChooseFileImageWithPercentage(
                  iconPath: fileIsSelectedFromGallery
                      ? iconPath
                      : Prefs.getString(Prefs.myImage) ?? "",
                  isFile: fileIsSelectedFromGallery,
                  percentage: HelperClass.getPercentage(),
                ),
              )),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextsBody(BuildContext context) {
    return BlocConsumer<ProfileSettingsCubit, ProfileSettingsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          children: [
            TextFormFiledWidget(
                label: Prefs.getString(Prefs.myMail) ?? "",
                hint: StringsEn.email,
                isEnabled: false,
                onTextChanged: (ss) => {
                      email = ss,
                      BlocProvider.of<ProfileSettingsCubit>(context)
                          .textChanged(name, iconPath, email)
                    },
                controller: _emailController),
            TextFormFiledWidget(
                label: Prefs.getString(Prefs.myName) ?? "",
                hint: StringsEn.name,
                onTextChanged: (ss) => {
                      name = ss,
                      BlocProvider.of<ProfileSettingsCubit>(context)
                          .textChanged(name, iconPath, email)
                    },
                controller: _nameController),
          ],
        );
      },
    );
  }

  _getFromGallery(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    fileIsSelectedFromGallery = true;
    BlocProvider.of<ProfileSettingsCubit>(context)
        .textChanged(name, photo!.path, email);
    // final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
  }
}
