import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/ringy/application/bloc/user_list/user_list_bloc.dart';
import 'package:flutter_chat/ringy/domain/entities/users/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/no_user_widget.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/addFriends/search_friends_page.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/o2o/o2o_users/widgets/user_item_forward_tile.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/o2o/o2o_users/widgets/user_item_tile.dart';
import 'package:flutter_chat/ringy/presentation/routes/router.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';
import 'package:auto_route/auto_route.dart';

import '../../../../../../../injections.dart';
import '../../../addFriends/widgets/friend_requests_item_tile_with_texts.dart';
import '../../../addFriends/widgets/friend_requests_send_item_tile.dart';

class O2OUsersPage extends StatelessWidget {
  final bool showUsers;

  const O2OUsersPage(this.showUsers, {Key? key}) : super(key: key);

  //context.pushRoute(O2OUsersRoute(showUsers: true));

  @override
  Widget build(BuildContext context) {
    final UserListBloc userListBloc = serviceLocator<UserListBloc>();

    return Scaffold(
        appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: RingyColors.lightWhite,
            ),
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            elevation: 0,
            centerTitle: true,
            backgroundColor: RingyColors.lightWhite,
            title: Text(
              showUsers ? StringsEn.forwardTo : StringsEn.chat,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: RingyColors.primaryColor),
            ),
            actions: [
             if(!showUsers) GestureDetector(
                  onTap: () {
                    final page = SwitchFriendRoute();
                    context.pushRoute(page);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0, top: 12),
                    child: Icon(
                      Icons.person_add_alt_1,
                      color: RingyColors.primaryColor,
                    ),
                  ))
            ]),
        body: BlocProvider<UserListBloc>(
          create: (context) => userListBloc
            ..add(GetUsersEvent(Constants.projectId,
                Prefs.getString(Prefs.myUserId)!, showUsers)),
          child: BlocBuilder<UserListBloc, UserListState>(
            builder: (context, state) {
              if (state is LoadedState) {
                var mList = state.users;
                mList.sort((a, b) =>
                    a.latestMsgCreatedAt.compareTo(b.latestMsgCreatedAt));
                return _buildBody(context, mList, showUsers);
              } else if (state is NoUsersState) {
                return const NoItemWidget(
                    StringsEn.noFriendsFound, Icons.group);
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  color: RingyColors.primaryColor,
                ));
              }
            },
          ),
        ));

    //  _buildBody(context));
  }
}

Widget _buildBody(BuildContext context, List<UsersList> list, bool showUsers) {
  return ListView.separated(
    shrinkWrap: true,
    itemCount: list.length,
    separatorBuilder: (BuildContext context, int index) => const Divider(
      indent: 20,
      endIndent: 20,
    ),
    itemBuilder: (BuildContext context, int index) {
      final revereIndex = list.length - 1 - index;
      return showUsers
          ? UserItemForwardTile(model: list[revereIndex])
          // ? FriendRequestsSendItemTile(model: list[revereIndex])
          : UserItemTile(
              userModel: list[revereIndex],
              groupModel: null,
              isGroup: false,
            );
    },
  );
}
