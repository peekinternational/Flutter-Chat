import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/ringy/application/bloc/users/user_list/user_list_bloc.dart';
import 'package:flutter_chat/ringy/domain/entities/chat_message/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/presentation/core/widgets/no_user_widget.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/o2o/o2o_users/widgets/user_item_forward_tile.dart';
import 'package:flutter_chat/ringy/presentation/home/chat/o2o/o2o_users/widgets/user_item_tile.dart';
import 'package:flutter_chat/ringy/resources/colors.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:flutter_chat/ringy/resources/strings_en.dart';

import '../../../../../../../injections.dart';

class O2OUsersPage extends StatelessWidget {
  final bool showUsers;


  const O2OUsersPage(this.showUsers, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserListBloc userListBloc = serviceLocator<UserListBloc>();
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: RingyColors.lightWhite,
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: RingyColors.lightWhite,
          title: Text(
            showUsers ? StringsEn.forwardTo : StringsEn.chat,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: RingyColors.primaryColor),
          ),
        ),
        body: BlocProvider<UserListBloc>(
          create: (context) => userListBloc
            ..add(GetUsersEvent(
                Constants.projectId, Prefs.getString(Prefs.myUserId)!,showUsers)),
          child: BlocBuilder<UserListBloc, UserListState>(
            builder: (context, state) {
              if (state is LoadedState) {
                return _buildBody(context, state.users,showUsers);
              } else if (state is NoUsersState) {
                return  const NoItemWidget(StringsEn.noFriendsFound,Icons.group);
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

Widget _buildBody(BuildContext context, List<UsersList> list,bool showUsers) {
  return ListView.separated(
    shrinkWrap: true,
    itemCount: list.length,
    separatorBuilder: (BuildContext context, int index) => const Divider(
      indent: 20,
      endIndent: 20,
    ),
    itemBuilder: (BuildContext context, int index) {
      return showUsers? UserItemForwardTile(model: list[index]):UserItemTile(model: list[index]);
    },
  );
}
