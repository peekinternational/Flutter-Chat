import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/ringy/application/bloc/users_list_for_group_bloc/users_list_for_group_bloc.dart';
import 'package:flutter_chat/ringy/domain/entities/users/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/image_or_first_character_users.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/no_user_widget.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/group/create_group/user_item_add_group_tile.dart';
import 'package:flutter_chat/ringy/presentation/routes/router.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../../../injections.dart';
import '../../../../core/widgets/center_circular_progress.dart';

class AddGroupUsersPage extends StatelessWidget {
  const AddGroupUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UsersListForGroupBloc userListBloc =
        serviceLocator<UsersListForGroupBloc>();
    List<UsersList> mListSelected = [];
    ScrollController scrollController = ScrollController();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.arrow_forward),
            backgroundColor: RingyColors.primaryColor,
            onPressed: () {
              if (mListSelected.isNotEmpty) {
                context.pushRoute(
                    AddGroupSubjectRoute(mListSelected: mListSelected));
              } else {
                VxToast.show(context,
                    msg: StringsEn.noUserSelectedForGroupValidation);
              }
            }),
        appBar: _buildAppBar(context),
        body: BlocProvider<UsersListForGroupBloc>(
          create: (context) => userListBloc
            ..add(GetUsersForGroupEvent(
                Constants.projectId, Prefs.getString(Prefs.myUserId)!)),
          child: BlocBuilder<UsersListForGroupBloc, UsersListForGroupState>(
            builder: (context, state) {
              if (state is LoadedState) {
                mListSelected = state.selectedUsers;
                return _buildBody(context, state.users, mListSelected,
                    userListBloc, scrollController);
              } else if (state is NoUsersState) {
                return const NoItemWidget(
                    StringsEn.noFriendsFound, Icons.group);
              } else {
                return const CenterCircularProgress();
              }
            },
          ),
        ));
  }

  _buildAppBar(BuildContext context) {
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
      title: Column(
        children: [
          Text(
            StringsEn.newGroup,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: RingyColors.primaryColor),
          ),
          Text(
            StringsEn.addParticipant,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: RingyColors.unSelectedColor),
          )
        ],
      ),
    );
  }

  Widget _buildBody(
      BuildContext context,
      List<UsersList> list,
      List<UsersList> listSelected,
      UsersListForGroupBloc userListBloc,
      ScrollController scrollController) {
    return Column(
      children: [
        if (listSelected.isNotEmpty)
          _buildSelectedList(context, listSelected, scrollController),
        if (listSelected.isNotEmpty) const Divider(),
        _buildUsersList(
            context, list, scrollController, userListBloc, listSelected),
      ],
    );
  }

  _buildSelectedList(BuildContext context, listSelected, scrollController) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listSelected.length,
          controller: scrollController,
          itemBuilder: (context, index) {
            return TweenAnimationBuilder(
              duration: const Duration(milliseconds: 300),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) => Transform.scale(
                scale: value,
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
                    SizedBox(
                      width: 60,
                      child: Center(
                        child: Text(listSelected[index].name!,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ]),
                ),
              ),
            );
          }),
    );
  }

  _buildUsersList(BuildContext context, List<UsersList> list,
      ScrollController scrollController, userListBloc, listSelected) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: list.length,
        scrollDirection: Axis.vertical,
        separatorBuilder: (BuildContext context, int index) => const Divider(
          indent: 20,
          endIndent: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              splashColor: Colors.transparent,
              onTap: () => {
                    userListBloc..add(SelectUserForGroupEvent(index)),
                    if (listSelected.isNotEmpty)
                      {
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent + 100,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        )
                      }
                  },
              child: UserItemAddGroupTile(model: list[index]));
        },
      ),
    );
  }
}
