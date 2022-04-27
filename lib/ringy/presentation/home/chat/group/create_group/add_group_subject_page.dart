import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/ringy/application/cubit/group_create/group_create_cubit.dart';
import 'package:flutter_chat/ringy/domain/entities/users/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/choose_file_image.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/file_Image_widget.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/image_or_first_character_users.dart';
import 'package:flutter_chat/ringy/presentation/routes/router.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../injections.dart';

class AddGroupSubjectPage extends StatelessWidget {
  final List<UsersList> mListSelected;

  AddGroupSubjectPage(this.mListSelected, {Key? key}) : super(key: key);
  String iconPath = "";

  @override
  Widget build(BuildContext context) {
    final GroupCreateCubit groupCreateCubit =
        serviceLocator<GroupCreateCubit>();
    return BlocProvider<GroupCreateCubit>(
      create: (context) => GroupCreateCubit(groupCreateCubit.repository),
      child: _scaffold(context),
    );
  }

  Widget _scaffold(BuildContext context) {
    final TextEditingController _textEditingController =
        TextEditingController();
    return Scaffold(
      floatingActionButton: _buildFabButton(context, _textEditingController),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: RingyColors.lightWhite,
        ),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        backgroundColor: RingyColors.lightWhite,
        title: Column(
          children: [
            Text(
              StringsEn.newGroup,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: RingyColors.primaryColor),
            ),
            Text(
              StringsEn.addSubject,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: RingyColors.unSelectedColor),
            )
          ],
        ),
      ),
      body: _buildBody(context, mListSelected, _textEditingController),
    );
  }

  Widget _buildFabButton(
      BuildContext context, TextEditingController _textEditingController) {
    return BlocConsumer<GroupCreateCubit, GroupCreateState>(
      listener: (context, state) {
        if (state is ChangeIconState) {
          iconPath = state.icon;
        }
        else if (state is GroupErrorState) {
          VxToast.show(context, msg: state.error);
        } else if (state is GroupSuccessState) {
          context.router.pushAndPopUntil(HomeRoute(currentIndex: 1), predicate: (Route<dynamic> route) => false);
        }
      },
      builder: (context, state) {
        if (state is GroupLoadingState) {
          return CircularProgressIndicator(
            color: RingyColors.primaryColor,
          );
        }
        return FloatingActionButton(
            child: const Icon(Icons.check),
            backgroundColor: RingyColors.primaryColor,
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (mListSelected.isNotEmpty) {
                if (_textEditingController.text.isNotEmpty) {
                  BlocProvider.of<GroupCreateCubit>(context).createGroup(
                      _textEditingController.text, mListSelected, iconPath);
                } else {
                  VxToast.show(context,
                      msg: StringsEn.noSubjectSelectedForGroupValidation);
                }
              } else {
                VxToast.show(context,
                    msg: StringsEn.noUserSelectedForGroupValidation);
              }
            });
      },
    );
  }

  Widget _buildBody(BuildContext context, List<UsersList> mListSelected,
      TextEditingController _textEditingController) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSubjectRow(context, _textEditingController),
          _buildSelectedList(context, mListSelected),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildSubjectRow(
      BuildContext context, TextEditingController _textEditingController) {
    return Container(
      height: 200,
      color: RingyColors.lightWhite,
      padding: const EdgeInsets.all(28.0),
      width: double.infinity,
      child: Center(
        child: Row(
          children: [
            BlocConsumer<GroupCreateCubit, GroupCreateState>(
              listener: (context, state) {
                if (state is ChangeIconState) {
                  iconPath = state.icon;
                }
              },
              builder: (context, state) {
                return InkWell(
                  onTap: () => _getFromGallery(context),
                  child: ChooseFileImage(iconPath: iconPath),
                );
              },
            ),
            Expanded(
                child: TextField(
              controller: _textEditingController,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedList(
    BuildContext context,
    List<UsersList> listSelected,
  ) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listSelected.length,
          itemBuilder: (context, index) {
            return DelayedDisplay(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  ImageOrFirstCharacterUsers(
                    radius: 25,
                    maxRadius: 26,
                    imageUrl: listSelected[index].userImage!,
                    name: listSelected[index].name!,
                    onlineStatus: listSelected[index].onlineStatus!,
                    showOnlineStatus: false,
                  ),
                  Text(listSelected[index].name!)
                ]),
              ),
            );
          }),
    );
  }

  _getFromGallery(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    BlocProvider.of<GroupCreateCubit>(context).changeIcon(photo!.path);
    // final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
  }
}
